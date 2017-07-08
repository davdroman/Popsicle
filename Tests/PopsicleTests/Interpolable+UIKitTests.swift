//
//  Interpolable+UIKitTests.swift
//  Popsicle
//
//  Created by David Román Aguirre on 17/07/16.
//

#if os(iOS) || os(watchOS) || os(tvOS)

import XCTest
@testable import Popsicle

func ~= (lhs: UIColor, rhs: UIColor) -> Bool {
	var lhsRed = CGFloat()
	var lhsGreen = CGFloat()
	var lhsBlue = CGFloat()
	var lhsAlpha = CGFloat()

	var rhsRed = CGFloat()
	var rhsGreen = CGFloat()
	var rhsBlue = CGFloat()
	var rhsAlpha = CGFloat()

	lhs.getRed(&lhsRed, green: &lhsGreen, blue: &lhsBlue, alpha: &lhsAlpha)
	rhs.getRed(&rhsRed, green: &rhsGreen, blue: &rhsBlue, alpha: &rhsAlpha)

	return lhsRed ~= rhsRed
		&& lhsGreen ~= rhsGreen
		&& lhsBlue ~= rhsBlue
		&& lhsAlpha ~= rhsAlpha
}

class InterpolableUIKitTests: XCTestCase {

	func testInterpolableColor() {
		InterpolableTests.test(
			initialValue: UIColor(white: 1, alpha: 0),
			finalValue: UIColor(white: 0, alpha: 1),
			interpolatedValues: [
				UIColor(white: 1, alpha: 0),
				UIColor(white: 0.75, alpha: 0.25),
				UIColor(white: 0.66, alpha: 0.33),
				UIColor(white: 0.5, alpha: 0.5),
				UIColor(white: 0.33, alpha: 0.66),
				UIColor(white: 0.25, alpha: 0.75),
				UIColor(white: 0, alpha: 1)
			],
			times: [0, 0.25, 0.33, 0.5, 0.66, 0.75, 1],
			function: ~=
		)
	}
}

#endif
