//
//  KeyPathRepresentable+UIKit.swift
//  Popsicle
//
//  Created by David Román Aguirre on 30/06/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import UIKit

extension NSLayoutAttribute: KeyPathRepresentable {
	public func object(from originalObject: NSObject) -> NSObject {
		if let view = originalObject as? UIView {

			// There's a chance the constraint is fixed and attached to the view, not the superview.
			if self == .width || self == .height {
				for constraint in view.constraints where constraint.secondItem == nil {
					return constraint
				}
			}

			if let superview = view.superview {
				for constraint in superview.constraints {
					let firstItem = constraint.firstItem as? NSObject
					let firstAttribute = constraint.firstAttribute

					let secondItem = constraint.secondItem as? NSObject
					let secondAttribute = constraint.secondAttribute

					if (firstItem == view && firstAttribute == self) || (secondItem == view && secondAttribute == self) {
						return constraint
					}
				}
			}
		}

		fatalError("Object \(originalObject) is not a UIView or is not constrained to a superview")
	}

	public func keyPath() -> String {
		return #keyPath(NSLayoutConstraint.constant)
	}
}
