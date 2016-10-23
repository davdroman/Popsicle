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

struct Pole<I: Interpolable> where I.ValueType == I {
	let time: Time
	let value: I
	let easingFunction: EasingFunction

	init(time: Time, value: I, easingFunction: @escaping EasingFunction) {
		self.time = time
		self.value = value
		self.easingFunction = easingFunction
	}
}

/// `Interpolation` defines an interpolation of an object property.
public class Interpolation<I: Interpolable, P: PropertyProtocol>: Timeable where I == I.ValueType, P.Value == I {

	let object: P.Object
	let property: P
	var poles = [Pole<P.Value>]()

	public init(_ object: P.Object, _ property: P) {
		self.object = object
		self.property = property
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

	func setPole(at time: Time, value: I, easingFunction: @escaping EasingFunction = linearEasingFunction) {
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
			property.bindingClosure(object, self[time])
		}
	}
}

extension Interpolation: Equatable {
	public static func == (lhs: Interpolation, rhs: Interpolation) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}

extension Interpolation: Hashable {
	public var hashValue: Int {
		return description.hashValue
	}
}

extension Interpolation: CustomStringConvertible {
	public var description: String {
		return "\(object) | \(property) | \(poles)"
	}
}
