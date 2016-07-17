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
		get { fatalError("Access to `time` property in a array of `Timeable` elements is not allowed") }
		set { self.forEach { (var timeable) in timeable.time = newValue } }
	}
}

/// `Interpolation` defines an interpolation which changes some `NSObject` value given by a key path.
public class Interpolation<I: Interpolable> : Timeable, Hashable {

	public typealias Pole = (I, EasingFunction)

	let object: NSObject
	let keyPath: String
	var poles = [Time: Pole]()

	public init<O: NSObject>(_ object: O, _ keyPath: KeyPath<O, I>) {
		self.object = keyPath.keyPathRepresentable.object(from: object)
		self.keyPath = keyPath.keyPathRepresentable.keyPath()

		if !self.object.responds(to: NSSelectorFromString(self.keyPath)) {
			fatalError("Please make sure the key path \"\(self.keyPath)\" you're referring to for an object of type <\(self.object.dynamicType)> is valid")
		}
	}

	/// An initializer with `keyPath` as a `KeyPathRepresentable` parameter.
	/// You should try to avoid this method unless absolutely necessary, due to its unsafety.
	/// Otherwise please  consider #keyPath function introduced Swift 3 for a higher compile-time safety.
	public convenience init(_ object: NSObject, _ keyPath: KeyPathRepresentable) {
		self.init(object, KeyPath(keyPath))
	}

	public subscript(time: Time, rest: Time...) -> I? {
		get {
			assert(poles.count >= 2, "You must specify at least 2 poles for an interpolation to be performed")

			if let existingPole = poles[time] {
				return existingPole.0
			} else if let timeInterval = poles.keys.sorted().elementsAround(time) {

				guard let fromTime = timeInterval.0 else {
					return poles[timeInterval.1!]!.0
				}

				guard let toTime = timeInterval.1 else {
					return poles[timeInterval.0!]!.0
				}

				let easingFunction = poles[fromTime]!.1

				let limitedTime = (time-fromTime)/(toTime-fromTime)
				let simplifiedTime = min(1, max(0, limitedTime))

				let progress = easingFunction(simplifiedTime)
				return I.interpolate(from: poles[fromTime]!.0, to: poles[toTime]!.0, at: progress)
			}

			return nil
		}

		set {
			([time] + rest).forEach { poles[$0] = (newValue!, linearEasingFunction) }
		}
	}

	public subscript(f time: Time, rest: Time...) -> Pole? {
		get {
			return nil
		}

		set {
			([time] + rest).forEach { poles[$0] = (newValue!.0, linearEasingFunction) }
		}
	}

	public var time: Time = 0 {
		didSet {
			self.object.setValue(self[time] as? AnyObject, forKeyPath: self.keyPath)
		}
	}

	public var hashValue: Int {
		return "\(self.object)+\(self.keyPath)".hashValue
	}
}

public func ==<T: Interpolable>(lhs: Interpolation<T>, rhs: Interpolation<T>) -> Bool {
	return lhs.hashValue == rhs.hashValue
}

extension Array where Element: Comparable {
	func elementPairs() -> [(Element, Element)]? {
		if self.count >= 2 {
			var elementPairs: [(Element, Element)] = []

			for (i, e) in self.sorted().enumerated() {
				if i+1 < self.count {
					elementPairs.append((e, self[i+1]))
				}
			}

			return elementPairs
		}

		return nil
	}

	func elementsAround(_ element: Element) -> (Element?, Element?)? {
		if let pairs = self.elementPairs() {

			let minElement = pairs.first!.0
			let maxElement = pairs.last!.1

			if element < minElement {
				return (nil, minElement)
			}

			if element > maxElement {
				return (maxElement, nil)
			}

			for (e1, e2) in pairs where (e1...e2).contains(element) {
				return (e1, e2)
			}
		}

		return nil
	}
}
