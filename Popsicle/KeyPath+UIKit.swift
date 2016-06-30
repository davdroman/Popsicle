//
//  UIKit+KeyPath.swift
//  Popsicle
//
//  Created by David Román Aguirre on 30/06/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import UIKit

public let alpha                          = KeyPath<UIView, CGFloat>(#keyPath(UIView.alpha))
public let backgroundColor                = KeyPath<UIView, UIColor>(#keyPath(UIView.backgroundColor))
public let barTintColor                   = KeyPath<UINavigationBar, UIColor>(#keyPath(UINavigationBar.barTintColor))
public let borderColor                    = KeyPath<CALayer, CGFloat>(#keyPath(CALayer.borderColor))
public let borderWidth                    = KeyPath<CALayer, CGFloat>(#keyPath(CALayer.borderWidth))
public let constant                       = KeyPath<NSLayoutConstraint, CGFloat>(#keyPath(NSLayoutConstraint.constant))
public let cornerRadius                   = KeyPath<CALayer, CGFloat>(#keyPath(CALayer.cornerRadius))
public let hidden                         = KeyPath<UIView, Bool>(#keyPath(UIView.isHidden))
public let textColor                      = KeyPath<UIView, UIColor>(#keyPath(UILabel.textColor))
public let tintColor                      = KeyPath<UIView, UIColor>(#keyPath(UIView.tintColor))
public let transform                      = KeyPath<UIView, CGAffineTransform>(#keyPath(UIView.transform))

public let lastbaselineConstraint         = KeyPath<UIView, CGFloat>(NSLayoutAttribute.lastBaseline)
public let firstBaselineConstraint        = KeyPath<UIView, CGFloat>(NSLayoutAttribute.firstBaseline)

public let topConstraint                  = KeyPath<UIView, CGFloat>(NSLayoutAttribute.top)
public let leftConstraint                 = KeyPath<UIView, CGFloat>(NSLayoutAttribute.left)
public let rightConstraint                = KeyPath<UIView, CGFloat>(NSLayoutAttribute.right)
public let bottomConstraint               = KeyPath<UIView, CGFloat>(NSLayoutAttribute.bottom)
public let leadingConstraint              = KeyPath<UIView, CGFloat>(NSLayoutAttribute.leading)
public let trailingConstraint             = KeyPath<UIView, CGFloat>(NSLayoutAttribute.trailing)

public let leftMarginConstraint           = KeyPath<UIView, CGFloat>(NSLayoutAttribute.leftMargin)
public let rightMarginConstraint          = KeyPath<UIView, CGFloat>(NSLayoutAttribute.rightMargin)
public let topMarginConstraint            = KeyPath<UIView, CGFloat>(NSLayoutAttribute.topMargin)
public let bottomMarginConstraint         = KeyPath<UIView, CGFloat>(NSLayoutAttribute.bottomMargin)
public let leadingMarginConstraint        = KeyPath<UIView, CGFloat>(NSLayoutAttribute.leadingMargin)
public let trailingMarginConstraint       = KeyPath<UIView, CGFloat>(NSLayoutAttribute.trailingMargin)

public let centerXConstraint              = KeyPath<UIView, CGFloat>(NSLayoutAttribute.centerX)
public let centerYConstraint              = KeyPath<UIView, CGFloat>(NSLayoutAttribute.centerY)

public let centerXWithinMarginsConstraint = KeyPath<UIView, CGFloat>(NSLayoutAttribute.centerXWithinMargins)
public let centerYWithinMarginsConstraint = KeyPath<UIView, CGFloat>(NSLayoutAttribute.centerYWithinMargins)

public let widthConstraint                = KeyPath<UIView, CGFloat>(NSLayoutAttribute.width)
public let heightConstraint               = KeyPath<UIView, CGFloat>(NSLayoutAttribute.height)
