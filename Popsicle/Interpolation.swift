//
//  Interpolation.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

protocol ObjectReferable {
	var objectReference: NSObject { get }
}

protocol Timeable {
	func setTime(_ time: Time)
}

/// `Interpolation` defines an interpolation which changes some `NSObject` value given by a key path.
public class Interpolation<T: Interpolable> : Equatable, ObjectReferable, Timeable {
	let object: NSObject
	let keyPath: String

	let originalObject: NSObject
	var objectReference: NSObject { return self.originalObject }

	typealias Pole = (T.ValueType, EasingFunction)
	private var poles: [Time: Pole] = [:]

	public init<U: NSObject>(_ object: U, _ keyPath: KeyPath<U, T>) {
		self.originalObject = object
		(self.object, self.keyPath) = NSObject.filteredObjectAndKeyPath(withObject: object, andKeyPath: keyPath)

		if !self.object.responds(to: NSSelectorFromString(self.keyPath)) {
			assertionFailure("Please make sure the key path \"" + self.keyPath + "\" you're referring to for an object of type <" + NSStringFromClass(self.object.dynamicType) + "> is invalid")
		}
	}

	/// A convenience initializer with `keyPath` as a `String` parameter. You should try to avoid this method unless absolutely necessary, due to its unsafety.
	public convenience init(_ object: NSObject, _ keyPath: String) {
		self.init(object, KeyPath(keyPathable: keyPath))
	}

	/// Sets a specific easing function for the interpolation to be performed with for a given time.
	///
	/// - parameter easingFunction: the easing function to use.
	/// - parameter time:           the time where the easing function should be used.
	public func setEasingFunction(_ easingFunction: EasingFunction, forTime time: Time) {
		self.poles[time]?.1 = easingFunction
	}

	public subscript(time1: Time, rest: Time...) -> T.ValueType? {
		get {
			assert(poles.count >= 2, "You must specify at least 2 poles for an interpolation to be performed")
			if let existingPole = poles[time1] {
				return existingPole.0
			} else if let timeInterval = poles.keys.sorted().elementsAround(time1) {

				guard let fromTime = timeInterval.0 else {
					return poles[timeInterval.1!]!.0
				}

				guard let toTime = timeInterval.1 else {
					return poles[timeInterval.0!]!.0
				}

				let easingFunction = poles[fromTime]!.1
				let progress = easingFunction(self.progress(fromTime, toTime, time1))
				return T.interpolate(from: poles[fromTime]!.0, to: poles[toTime]!.0, withProgress: progress)
			}

			return nil
		}

		set {
			var times = [time1]
			times.append(contentsOf: rest)
			for time in times {
				poles[time] = (newValue!, EasingFunctionLinear)
			}
		}
	}

	func progress(_ fromTime: Time, _ toTime: Time, _ currentTime: Time) -> Progress {
		let p = (currentTime-fromTime)/(toTime-fromTime)
		return min(1, max(0, p))
	}

	func setTime(_ time: Time) {
		self.object.setValue(T.objectify(self[time]!), forKeyPath: self.keyPath)
	}
}

public func ==<T: Interpolable>(lhs: Interpolation<T>, rhs: Interpolation<T>) -> Bool {
	return lhs.object == rhs.object && lhs.keyPath == rhs.keyPath
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
