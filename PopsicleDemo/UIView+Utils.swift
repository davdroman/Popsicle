//
//  UIView+Utils.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

extension UIView {
	static func viewsByClassInNib(named name: String) -> [String: UIView] {
		guard let nibs = Bundle.main.loadNibNamed(name, owner: self, options: nil) else {
			return [:]
		}

		return nibs
			.flatMap { $0 as? UIView }
			.map { (NSStringFromClass(type(of: $0)), $0) }
			.reduce([String: UIView]()) { acc, element in
				var acc = acc
				acc[element.0] = element.1 as? UIView
				return acc
			}
	}

	func pinToSuperviewEdges() {
		translatesAutoresizingMaskIntoConstraints = false

		for attribute in [.top, .left, .bottom, .right] as [NSLayoutAttribute] {
			let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: self.superview, attribute: attribute, multiplier: 1, constant: 0)

			superview?.addConstraint(constraint)
		}
	}
}
