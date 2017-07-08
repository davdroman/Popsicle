//
//  InterpolationTests.swift
//  Popsicle
//
//  Created by David Román Aguirre on 18/07/16.
//

import XCTest
import Popsicle

class InterpolationTests: XCTestCase {

	class DummyObject {
		var value: Float = 0
	}

	func testPolesOrder() {
		let interpolation = Interpolation(DummyObject(), \.value)
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
