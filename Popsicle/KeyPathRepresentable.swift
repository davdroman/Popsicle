//
//  KeyPathRepresentable.swift
//  Popsicle
//
//  Created by David Román Aguirre on 30/06/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

/// A `KeyPathRepresentable` defines the relationship between a given `NSObject` and its key path.
public protocol KeyPathRepresentable {
	func object(from originalObject: NSObject) -> NSObject
	func keyPath() -> String
}

extension String: KeyPathRepresentable {
	public func object(from originalObject: NSObject) -> NSObject {
		return originalObject
	}

	public func keyPath() -> String {
		return self
	}
}
