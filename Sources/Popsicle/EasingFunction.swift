//
//  EasingFunction.swift
//  Popsicle
//
//  Created by David Román Aguirre on 06/15/15.
//

import Foundation

public protocol LinearTimeConverter {
	func time(forLinearTime time: Time) -> Time
}

public enum EasingFunction: LinearTimeConverter {
	/// Simple linear tweening function — no easing, no acceleration.
	case linear
	/// Quadratic easing in function — accelerating from zero velocity.
	case easeInQuad
	/// Quadratic easing out function — decelerating to zero velocity.
	case easeOutQuad
	/// Quadratic easing in/out function — acceleration until halfway, then deceleration.
	case easeInOutQuad
	/// Cubic easing in function — accelerating from zero velocity.
	case easeInCubic
	/// Cubic easing out function — decelerating to zero velocity.
	case easeOutCubic
	/// Cubic easing in/out function — acceleration until halfway, then deceleration
	case easeInOutCubic
	/// Bounce easing in function — exponentially incresing bounce.
	case easeInBounce
	/// Bounce easing out function — exponentially decreasing bounce.
	case easeOutBounce

	public func time(forLinearTime t: Time) -> Time {
		switch self {
		case .linear:
			return t
		case .easeInQuad:
			return t * t
		case .easeOutQuad:
			return t * (2 - t)
		case .easeInOutQuad:
			if t < 0.5 { return 2 * t * t }
			return -1 + ((4 - (2 * t)) * t)
		case .easeInCubic:
			return t * t * t
		case .easeOutCubic:
			return pow(t - 1, 3) + 1
		case .easeInOutCubic:
			if t < 0.5 { return 4 * pow(t, 3) }
			return ((t - 1) * pow((2 * t) - 2, 2)) + 1
		case .easeInBounce:
			return 1 - EasingFunction.easeOutBounce.time(forLinearTime: 1 - t)
		case .easeOutBounce:
			if t < (4.0 / 11.0) {
				return pow((11.0 / 4.0), 2) * pow(t, 2)
			}
			if t < (8.0 / 11.0) {
				return (3.0 / 4.0) + (pow((11.0 / 4.0), 2) * pow(t - (6.0 / 11.0), 2))
			}
			if t < (10.0 / 11.0) {
				return (15.0 / 16.0) + (pow((11.0 / 4.0), 2) * pow(t - (9.0 / 11.0), 2))
			}
			return (63.0 / 64.0) + (pow((11.0 / 4.0), 2) * pow(t - (21.0 / 22.0), 2))
		}
	}
}
