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
		case .left:
			type = "Left"

		case .right:
			type = "Right"

		case .top:
			type = "Top"

		case .bottom:
			type = "Bottom"

		case .leading:
			type = "Leading"

		case .trailing:
			type = "Trailing"

		case .width:
			type = "Width"

		case .height:
			type = "Height"

		case .centerX:
			type = "CenterX"

		case .centerY:
			type = "CenterY"

		case .lastBaseline:
			type = "Baseline"

		case .firstBaseline:
			type = "FirstBaseline"

		case .leftMargin:
			type = "LeftMargin"

		case .rightMargin:
			type = "RightMargin"

		case .topMargin:
			type = "TopMargin"

		case .bottomMargin:
			type = "BottomMargin"

		case .leadingMargin:
			type = "LeadingMargin"

		case .trailingMargin:
			type = "TrailingMargin"

		case .centerXWithinMargins:
			type = "CenterXWithinMargins"

		case .centerYWithinMargins:
			type = "CenterYWithinMargins"

		case .notAnAttribute:
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

public let baselineConstraint             = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.lastBaseline)
public let firstBaselineConstraint        = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.firstBaseline)

public let topConstraint                  = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.top)
public let leftConstraint                 = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.left)
public let rightConstraint                = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.right)
public let bottomConstraint               = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.bottom)
public let leadingConstraint              = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.leading)
public let trailingConstraint             = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.trailing)

public let leftMarginConstraint           = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.leftMargin)
public let rightMarginConstraint          = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.rightMargin)
public let topMarginConstraint            = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.topMargin)
public let bottomMarginConstraint         = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.bottomMargin)
public let leadingMarginConstraint        = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.leadingMargin)
public let trailingMarginConstraint       = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.trailingMargin)

public let centerXConstraint              = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.centerX)
public let centerYConstraint              = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.centerY)

public let centerXWithinMarginsConstraint = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.centerXWithinMargins)
public let centerYWithinMarginsConstraint = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.centerYWithinMargins)

public let widthConstraint                = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.width)
public let heightConstraint               = KeyPath<UIView, CGFloat>(keyPathable: NSLayoutAttribute.height)

extension NSObject {
	static func filteredObjectAndKeyPath<T: NSObject, U: Interpolable>(withObject object: T, andKeyPath keyPath: KeyPath<T, U>) -> (NSObject, String) {
		if let view = object as? UIView, let superview = view.superview, let attribute = keyPath.keyPathable as? NSLayoutAttribute {
            
            let constrainedView = (attribute == .width || attribute == .height) ? view : superview
            
            for constraint in constrainedView.constraints where
                !constraint.isKind(of: NSClassFromString("NSContentSizeLayoutConstraint")!) &&
                ((constraint.firstItem as? NSObject == view && constraint.firstAttribute == attribute) ||
                    (constraint.secondItem as? NSObject == view && constraint.secondAttribute == attribute)) {
                        return (constraint, constant.keyPathable.stringify())
            }
		}

		return (object, keyPath.keyPathable.stringify())
	}
}
