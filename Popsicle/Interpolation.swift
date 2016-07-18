//
//  Interpolation.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

public protocol Timeable {
	var time: Time { get set }
}

extension Sequence where Iterator.Element: Timeable {
	var time: Time {
		get { fatalError("`Sequence.time` can only be used as a setter.") }
		set { self.forEach { (var timeable) in timeable.time = newValue } }
	}
}

struct Pole<I: Interpolable where I.ValueType == I> {
	let time: Time
	let value: I
	let easingFunction: EasingFunction

	init(time: Time, value: I, easingFunction: EasingFunction) {
		self.time = time
		self.value = value
		self.easingFunction = easingFunction
	}
}

/// `Interpolation` defines an interpolation which changes some `NSObject` value given by a key path.
public class Interpolation<I: Interpolable where I.ValueType == I> : Timeable, Hashable, CustomStringConvertible {

	// I was originally going to use a simple typealias to represent `Pole`s
	// however this seems to produce a compiler segmentation fault.
	// Uncomment this line and see for yourself.
	// typealias Pole = (time: Time, value: I, easingFunction: EasingFunction)

	let object: NSObject
	let keyPath: String
	var poles = [Pole<I>]()

	public init<O: NSObject>(_ object: O, _ keyPath: KeyPath<O, I>) {
		self.object = keyPath.keyPathRepresentable.object(from: object)
		self.keyPath = keyPath.keyPathRepresentable.keyPath()

		if !self.object.responds(to: NSSelectorFromString(self.keyPath)) {
			fatalError("Please make sure the key path \"\(self.keyPath)\" you're referring to for an object of type <\(self.object.dynamicType)> is valid")
		}
	}

	/// An initializer with `keyPath` as a `KeyPathRepresentable` parameter.
	/// You should try to avoid this method unless absolutely necessary, due to its unsafety.
	/// Otherwise please consider using #keyPath, introduced in Swift 3 for higher compile-time safety.
	public convenience init(_ object: NSObject, _ keyPath: KeyPathRepresentable) {
		self.init(object, KeyPath(keyPath))
	}

	public subscript(times: Time...) -> I {
		get { return poleValue(at: times.first!) }
		set { times.forEach { setPole(at: $0, value: newValue) } }
	}

	public subscript(f times: Time...) -> (I, EasingFunction) {
		get { fatalError("`Interpolation[f]` can only be used as a setter.") }
		set { times.forEach { setPole(at: $0, value: newValue.0, easingFunction: newValue.1) } }
	}

	func poleValue(at time: Time) -> I {
		assert(poles.count >= 2, "You must specify at least 2 poles for an interpolation to be performed")

		var value: I
		let indexAfter = indexOfPole(after: time) ?? poles.count
		switch indexAfter {
		case 0:
			value = poles[0].value
		case 1 ..< poles.count:
			let poleBefore = poles[indexAfter - 1]
			let poleAfter = poles[indexAfter]
			let simplifiedTime = self.time(from: poleBefore.time, to: poleAfter.time, at: time)
			value = I.interpolate(from: poleBefore.value, to: poleAfter.value, at: poleBefore.easingFunction(simplifiedTime))
		default:
			value = poles.last!.value
		}
		return value
	}

	func setPole(at time: Time, value: I, easingFunction: EasingFunction = linearEasingFunction) {
		let index = indexOfPole(after: time) ?? poles.count
		poles.insert(Pole(time: time, value: value, easingFunction: easingFunction), at: index)
	}

	func indexOfPole(after time: Time) -> Int? {
		var indexAfter: Int?
		for (index, pole) in poles.enumerated() {
			if time < pole.time {
				indexAfter = index
				break
			}
		}
		return indexAfter
	}

	func time(from fromTime: Time, to toTime: Time, at atTime: Time) -> Time {
		let duration = toTime - fromTime
		return duration == 0 ? 0 : (atTime - fromTime) / duration
	}

	public var time: Time = 0 {
		didSet {
			self.object.setValue(self[time] as? AnyObject, forKeyPath: self.keyPath)
		}
	}

	public var hashValue: Int {
		return description.hashValue
	}

	public var description: String {
		return "\(self.object) | \(self.keyPath)"
	}
}

public func == <T: Interpolable>(lhs: Interpolation<T>, rhs: Interpolation<T>) -> Bool {
	return lhs.hashValue == rhs.hashValue
}
