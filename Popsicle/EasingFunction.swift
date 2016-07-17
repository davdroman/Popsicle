//
//  EasingFunction.swift
//  Popsicle
//
//  Created by David Román Aguirre on 06/15/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// `EasingFunction`s specify the rate of change of a parameter over `Time`.
public typealias EasingFunction = (Time) -> (Time)

/// Simple linear tweening function — no easing, no acceleration.
public let linearEasingFunction: EasingFunction = { t in
	return t
}

/// Quadratic easing in function — accelerating from zero velocity.
public let easeInQuadEasingFunction: EasingFunction = { t in
	return t * t
}

/// Quadratic easing out function — decelerating to zero velocity.
public let easeOutQuadEasingFunction: EasingFunction = { t in
	return t * (2 - t)
}

/// Quadratic easing in/out function — acceleration until halfway, then deceleration.
public let easeInOutQuadEasingFunction: EasingFunction = { t in
	if t < 0.5 { return 2 * t * t }
	return -1 + ((4 - (2 * t)) * t)
}

/// Cubic easing in function — accelerating from zero velocity.
public let easeInCubicEasingFunction: EasingFunction = { t in
	return t * t * t
}

/// Cubic easing out function — decelerating to zero velocity.
public let easeOutCubicEasingFunction: EasingFunction = { t in
	return pow(t - 1, 3) + 1
}

/// Cubic easing in/out function — acceleration until halfway, then deceleration
public let easeInOutCubicEasingFunction: EasingFunction = { t in
	if t < 0.5 { return 4 * pow(t, 3) }
	return ((t - 1) * pow((2 * t) - 2, 2)) + 1
}

/// Bounce easing in function — exponentially incresing bounce.
public let easeInBounceEasingFunction: EasingFunction = { t in
	return 1 - easeOutBounceEasingFunction(1 - t)
}

/// Bounce easing out function — exponentially decreasing bounce.
public let easeOutBounceEasingFunction: EasingFunction = { t in
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
