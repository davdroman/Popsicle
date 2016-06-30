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
		if let view = originalObject as? UIView, let superview = view.superview {
			let constrainedView = (self == .width || self == .height) ? view : superview
			
			for constraint in constrainedView.constraints where
				
				!constraint.isKind(of: NSClassFromString("NSContentSizeLayoutConstraint")!) &&
					((constraint.firstItem as? NSObject == view && constraint.firstAttribute == self) ||
						(constraint.secondItem as? NSObject == view && constraint.secondAttribute == self))
				
			{
				return constraint
			}
		}
		
		fatalError("Object \(originalObject) is not a UIView or is not constrained to a superview")
	}
	
	public func keyPath() -> String {
		return #keyPath(NSLayoutConstraint.constant)
	}
}
