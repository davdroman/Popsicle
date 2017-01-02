//
//  KeyPath+UIKitTests.swift
//  Popsicle
//
//  Created by David Román Aguirre on 17/07/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import XCTest
import Popsicle

class KeyPathUIKitTests: XCTestCase {

	class func test(attribute: NSLayoutAttribute) {
		let superview = UIView()
		let view = UIView()
		let layoutConstraint = NSLayoutConstraint(
			item: view,
			attribute: attribute,
			relatedBy: .equal,
			toItem: superview,
			attribute: attribute,
			multiplier: 1,
			constant: 0
		)

		superview.addSubview(view)
		superview.addConstraint(layoutConstraint)

		XCTAssert(attribute.object(from: view) == layoutConstraint)
		XCTAssert(attribute.keyPath == #keyPath(NSLayoutConstraint.constant))
	}

	class func test(parentlessAttribute attribute: NSLayoutAttribute) {
		let view = UIView()
		let layoutConstraint = NSLayoutConstraint(
			item: view,
			attribute: attribute,
			relatedBy: .equal,
			toItem: nil,
			attribute: .notAnAttribute,
			multiplier: 1,
			constant: 150
		)

		view.addConstraint(layoutConstraint)

		XCTAssert(attribute.object(from: view) == layoutConstraint)
		XCTAssert(attribute.keyPath == #keyPath(NSLayoutConstraint.constant))
	}

	func testLayoutAttributeKeyPathRepresentables() {
		[NSLayoutAttribute]([
			.left,
			.right,
			.top,
			.bottom,
			.leading,
			.trailing,
			.width,
			.height,
			.centerX,
			.centerY,
			.lastBaseline,
			.firstBaseline,
			.leftMargin,
			.rightMargin,
			.topMargin,
			.bottomMargin,
			.leadingMargin,
			.trailingMargin,
			.centerXWithinMargins,
			.centerYWithinMargins
		]).forEach { KeyPathUIKitTests.test(attribute: $0) }
	}

	func testParentlessLayoutAttributeKeyPathRepresentables() {
		[NSLayoutAttribute]([
			.width,
			.height
		]).forEach { KeyPathUIKitTests.test(parentlessAttribute: $0) }
	}
}
