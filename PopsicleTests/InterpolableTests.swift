//
//  InterpolableTests.swift
//  Popsicle
//
//  Created by David Román Aguirre on 17/07/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import XCTest
import Popsicle

class InterpolableTests: XCTestCase {

	func test<T: Interpolable>(initialValue: T, finalValue: T, interpolatedValues: [T], times: [Time], function: (T, T) -> Bool) {
		for (index, time) in times.enumerated() {
			let interpolatedValue = interpolatedValues[index]
			let computedInterpolatedValue = T.interpolate(from: initialValue, to: finalValue, at: time)
			XCTAssert(function(interpolatedValue, computedInterpolatedValue), "\(interpolatedValue) != \(computedInterpolatedValue)")
		}
	}

	func testInterpolableBool() {
		test(initialValue: false,
		     finalValue: true,
		     interpolatedValues: [false, false, false, true, true, true, true],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ==
		)

		test(initialValue: true,
		     finalValue: false,
		     interpolatedValues: [true, true, true, false, false, false, false],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ==
		)
	}

	func testInterpolableInt() {
		test(initialValue: 0,
		     finalValue: -10,
		     interpolatedValues: [0, -2, -3, -5, -6, -7, -10],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ==
		)

		test(initialValue: 0,
		     finalValue: 10,
		     interpolatedValues: [0, 2, 3, 5, 6, 7, 10],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ==
		)
	}

	func testInterpolableFloat() {
		test(initialValue: Float(0),
		     finalValue: -10,
		     interpolatedValues: [0, -2.5, -3.3, -5, -6.6, -7.5, -10],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ~=
		)

		test(initialValue: Float(0),
		     finalValue: 10,
		     interpolatedValues: [0, 2.5, 3.3, 5, 6.6, 7.5, 10],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ~=
		)
	}

	func testInterpolableDouble() {
		test(initialValue: 0.0,
		     finalValue: -10,
		     interpolatedValues: [0, -2.5, -3.3, -5, -6.6, -7.5, -10],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ~=
		)

		test(initialValue: 0.0,
		     finalValue: 10,
		     interpolatedValues: [0, 2.5, 3.3, 5, 6.6, 7.5, 10],
		     times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     function: ~=
		)
	}
}
