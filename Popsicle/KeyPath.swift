//
//  KeyPath.swift
//  Popsicle
//
//  Created by David Román Aguirre on 23/10/2016.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import Foundation

/// `KeyPathRepresentable` defines the relationship between a given `NSObject` and its key path.
public protocol KeyPathRepresentable {
	func object(from originalObject: NSObject) -> NSObject
	var keyPath: String { get }
}

extension String: KeyPathRepresentable {
	public func object(from originalObject: NSObject) -> NSObject {
		return originalObject
	}

	public var keyPath: String {
		return self
	}
}

public struct KeyPath<Object: NSObject, Value: Any>: PropertyProtocol {
	public let bindingClosure: (Object, Value) -> Void

	init(_ keyPathRepresentable: KeyPathRepresentable) {
		self.bindingClosure = { object, value in
			let dynamicValue: Any

			switch value {
			case let value as CGAffineTransform:
				dynamicValue = NSValue(cgAffineTransform: value)
			default:
				dynamicValue = value
			}

			keyPathRepresentable.object(from: object).setValue(dynamicValue, forKeyPath: keyPathRepresentable.keyPath)
		}
	}
}
