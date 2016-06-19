//
//  KeyPath.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// `KeyPathable` defines how a value is transformed to a valid `NSObject` key path.
public protocol KeyPathable {
	func stringify() -> String
}

extension String : KeyPathable {
	public func stringify() -> String {
		return self
	}
}

extension NSLayoutAttribute: KeyPathable {
	public func stringify() -> String {

		var type = "UnknownAttribute"

		switch(self) {
		case .Left:
			type = "Left"

		case .Right:
			type = "Right"

		case .Top:
			type = "Top"

		case .Bottom:
			type = "Bottom"

		case .Leading:
			type = "Leading"

		case .Trailing:
			type = "Trailing"

		case .Width:
			type = "Width"

		case .Height:
			type = "Height"

		case .CenterX:
			type = "CenterX"

		case .CenterY:
			type = "CenterY"

		case .LastBaseline:
			type = "Baseline"

		case .FirstBaseline:
			type = "FirstBaseline"

		case .LeftMargin:
			type = "LeftMargin"

		case .RightMargin:
			type = "RightMargin"

		case .TopMargin:
			type = "TopMargin"

		case .BottomMargin:
			type = "BottomMargin"

		case .LeadingMargin:
			type = "LeadingMargin"

		case .TrailingMargin:
			type = "TrailingMargin"

		case .CenterXWithinMargins:
			type = "CenterXWithinMargins"

		case .CenterYWithinMargins:
			type = "CenterYWithinMargins"

		case .NotAnAttribute:
			type = "NotAnAttribute"
		}

		return "NSLayoutAttribute." + type
	}
}

/// `KeyPath` defines a `NSObject`'s key path, constrained to specific `NSObject` and `Interpolable` types for higher safety.
public struct KeyPath<T: NSObject, U: Interpolable> {
	let keyPathable: KeyPathable

	public init(keyPathable: KeyPathable) {
		self.keyPathable = keyPathable
	}
}

public let alpha                          = KeyPath<UIView, CGFloat>(keyPathable: "alpha")
public let backgroundColor                = KeyPath<UIView, UIColor>(keyPathable: "backgroundColor")
public let barTintColor                   = KeyPath<UIView, UIColor>(keyPathable: "barTintColor")
public let borderColor                    = KeyPath<CALayer, CGFloat>(keyPathable: "borderColor")
public let borderWidth                    = KeyPath<CALayer, CGFloat>(keyPathable: "borderWidth")
public let constant                       = KeyPath<NSLayoutConstraint, CGFloat>(keyPathable: "constant")
public let cornerRadius                   = KeyPath<CALayer, CGFloat>(keyPathable: "cornerRadius")
public let hidden                         = KeyPath<UIView, Bool>(keyPathable: "hidden")
public let textColor                      = KeyPath<UIView, UIColor>(keyPathable: "textColor")
public let tintColor                      = KeyPath<UIView, UIColor>(keyPathable: "tintColor")
public let transform                      = KeyPath<UIView, CGAffineTransform>(keyPathable: "transform")

public let baselineConstraint             = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.LastBaseline)
public let firstBaselineConstraint        = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.FirstBaseline)

public let topConstraint                  = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Top)
public let leftConstraint                 = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Left)
public let rightConstraint                = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Right)
public let bottomConstraint               = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Bottom)
public let leadingConstraint              = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Leading)
public let trailingConstraint             = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Trailing)

public let leftMarginConstraint           = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.LeftMargin)
public let rightMarginConstraint          = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.RightMargin)
public let topMarginConstraint            = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.TopMargin)
public let bottomMarginConstraint         = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.BottomMargin)
public let leadingMarginConstraint        = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.LeadingMargin)
public let trailingMarginConstraint       = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.TrailingMargin)

public let centerXConstraint              = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.CenterX)
public let centerYConstraint              = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.CenterY)

public let centerXWithinMarginsConstraint = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.CenterXWithinMargins)
public let centerYWithinMarginsConstraint = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.CenterYWithinMargins)

public let widthConstraint                = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Width)
public let heightConstraint               = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.Height)

extension NSObject {
	static func filteredObjectAndKeyPath<T: NSObject, U: Interpolable>(withObject object: T, andKeyPath keyPath: KeyPath<T, U>) -> (NSObject, String) {
		if let view = object as? UIView, let superview = view.superview, let attribute = keyPath.keyPathable as? NSLayoutAttribute {
            
            let constrainedView = (attribute == .Width || attribute == .Height) ? view : superview
            
            for constraint in constrainedView.constraints where
                !constraint.isKindOfClass(NSClassFromString("NSContentSizeLayoutConstraint")!) &&
                ((constraint.firstItem as? NSObject == view && constraint.firstAttribute == attribute) ||
                    (constraint.secondItem as? NSObject == view && constraint.secondAttribute == attribute)) {
                        return (constraint, constant.keyPathable.stringify())
            }
		}

		return (object, keyPath.keyPathable.stringify())
	}
}
