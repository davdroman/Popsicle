//
//  Property.swift
//  Popsicle
//
//  Created by David Román Aguirre on 23/10/2016.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

public protocol PropertyProtocol {
	associatedtype Object
	associatedtype Value

	var bindingClosure: (Object, Value) -> Void { get }
}

public struct Property<Object: Any, Value: Any>: PropertyProtocol {
	public let bindingClosure: (Object, Value) -> Void
}
