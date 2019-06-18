//
//  Interpolation.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//

public protocol Timable {
	var time: Time { get set }
}

extension Array: Timable where Iterator.Element: Timable {
	public var time: Time {
		get {
			// TODO: improve (pick the most repeated time in the collection)
			return first?.time ?? 0
		}

		set {
			forEach { var interpolation = $0; interpolation.time = newValue }
		}
	}
}

/// `Interpolation` defines an interpolation of an object property.
public class Interpolation<O: AnyObject, I: Interpolable>: Timable {

	typealias Pole = (time: Time, value: I, easingFunction: EasingFunction)

	unowned let object: O
	let keyPath: ReferenceWritableKeyPath<O, I>
	var poles: [Pole] = []

	public init(_ object: O, _ keyPath: ReferenceWritableKeyPath<O, I>) {
		self.object = object
		self.keyPath = keyPath
	}

	public subscript(times: Time...) -> I {
		get { return poleValue(at: times.first!) }
		set { times.forEach { setPole(at: $0, value: newValue) } }
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
			value = I.interpolate(from: poleBefore.value, to: poleAfter.value, at: poleBefore.easingFunction.time(for: simplifiedTime))
		default:
			value = poles.last!.value
		}
		return value
	}

	func setPole(at time: Time, value: I, easingFunction: EasingFunction = .linear) {
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
			object[keyPath: keyPath] = self[time]
		}
	}
}

extension Interpolation: CustomStringConvertible {
	public var description: String {
		return "\(object) | \(keyPath) | \(poles)"
	}
}
