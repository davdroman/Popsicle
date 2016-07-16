//
//  EasingFunctionTests.swift
//  Popsicle
//
//  Created by David Román Aguirre on 13/07/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import XCTest
import Popsicle

infix operator ~= { }

func ~= (lhs: Double, rhs: Double) -> Bool {
	return abs(lhs - rhs) <= 0.02
}

class EasingFunctionTests: XCTestCase {

	func test(easingFunction: EasingFunction, initialValues: [Double], easingValues: [Double]) {
		for (index, initialValue) in initialValues.enumerated() {
			let easingValue = easingValues[index]
			let computedEasingValue = easingFunction(initialValue)
			XCTAssert(easingValue ~= computedEasingValue, "\(easingValue) != \(computedEasingValue)")
		}
	}

	func testLinearEasingFunction() {
		test(easingFunction: linearEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1]
		)
	}

	func testEaseInQuadEasingFunction() {
		test(easingFunction: easeInQuadEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.0625, 0.11, 0.25, 0.44, 0.56, 1]
		)
	}

	func testEaseOutQuadEasingFunction() {
		test(easingFunction: easeOutQuadEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.44, 0.55, 0.75, 0.88, 0.94, 1]
		)
	}

	func testEaseInOutQuadEasingFunction() {
		test(easingFunction: easeInOutQuadEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.125, 0.22, 0.5, 0.77, 0.87, 1]
		)
	}

	func testEaseInCubicEasingFunction() {
		test(easingFunction: easeInCubicEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.016, 0.036, 0.125, 0.29, 0.42, 1]
		)
	}

	func testEaseOutCubicEasingFunction() {
		test(easingFunction: easeOutCubicEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.58, 0.7, 0.875, 0.96, 0.98, 1]
		)
	}

	func testEaseInOutCubicEasingFunction() {
		test(easingFunction: easeInOutCubicEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.0625, 0.14, 0.5, 0.84, 0.94, 1]
		)
	}

	func testEaseInBounceEasingFunction() {
		test(easingFunction: easeInBounceEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.027, 0.13, 0.23, 0.125, 0.527, 1]
		)
	}

	func testEaseOutBounceEasingFunction() {
		test(easingFunction: easeOutBounceEasingFunction,
		     initialValues: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
		     easingValues: [0, 0.473, 0.824, 0.766, 0.85, 0.97, 1]
		)
	}
}
