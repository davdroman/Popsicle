//
//  InterpolationTests.swift
//  Popsicle
//
//  Created by David Román Aguirre on 18/07/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import XCTest
import Popsicle

class InterpolationTests: XCTestCase {

	func testEquality() {
		let view = UIView()
		let interpolation1 = Interpolation(view, alpha)
		let interpolation2 = Interpolation(view, alpha)

		XCTAssert(interpolation1 == interpolation2, "\(interpolation1) != \(interpolation2)")
	}

	func testInequality() {
		let interpolation1 = Interpolation(UIView(), alpha)
		let interpolation2 = Interpolation(UIView(), alpha)

		XCTAssert(interpolation1 != interpolation2, "\(interpolation1) == \(interpolation2)")
	}

	func testPolesOrder() {
		let interpolation = Interpolation(UIView(), alpha)
		interpolation[1] = 25
		interpolation[2] = 50
		interpolation[0] = 10

		XCTAssert(interpolation[0] == 10, "\(interpolation[0]) != 10")
		XCTAssert(interpolation[0.5] == 17.5, "\(interpolation[0.5]) != 17.5")
		XCTAssert(interpolation[1] == 25, "\(interpolation[1]) != 25")
		XCTAssert(interpolation[1.5] == 37.5, "\(interpolation[1.5]) != 37.5")
		XCTAssert(interpolation[2] == 50, "\(interpolation[2]) != 50")
	}
}
