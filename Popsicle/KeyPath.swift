//
//  KeyPath.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// `KeyPath` allows to refer to a specific `NSObject` key path in a safer way, by constraining it to a specific `NSObject` and `Interpolable`.
public struct KeyPath<O: NSObject, I: Interpolable> {
	let keyPathRepresentable: KeyPathRepresentable

	public init(_ keyPathRepresentable: KeyPathRepresentable) {
		self.keyPathRepresentable = keyPathRepresentable
	}
}
