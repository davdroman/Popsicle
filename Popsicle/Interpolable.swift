//
//  Interpolable.swift
//  Popsicle
//
//  Created by David Román Aguirre on 01/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// Pointer to a specific moment in the tweening of two `Interpolable` values.
public typealias Time = Double

/// `Interpolable` values can be tweened and mutated throughout time.
public protocol Interpolable {
	associatedtype ValueType

	/// Returns the result of tweening two values at a specific moment in time.
	static func interpolate(from fromValue: ValueType, to toValue: ValueType, at: Time) -> ValueType
}

extension Bool: Interpolable {
	public static func interpolate(from fromValue: Bool, to toValue: Bool, at time: Time) -> Bool {
		return time >= 0.5 ? toValue : fromValue
	}
}

extension Int: Interpolable {
	public static func interpolate(from fromValue: Int, to toValue: Int, at time: Time) -> Int {
		return Int(Double(fromValue) + Double(toValue-fromValue) * time)
	}
}

// Hopefully replaceable with `extension FloatingPoint: Interpolable`
// when Swift allows protocol extensions inheriting from other protocol(s).
extension Float: Interpolable {
	public static func interpolate(from fromValue: Float, to toValue: Float, at time: Time) -> Float {
		return fromValue + (toValue-fromValue) * Float(time)
	}
}

extension Double: Interpolable {
	public static func interpolate(from fromValue: Double, to toValue: Double, at time: Time) -> Double {
		return fromValue + (toValue-fromValue) * time
	}
}
