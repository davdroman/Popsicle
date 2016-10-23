//
//  InterpolationSet.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// A type-erased `Interpolation` collection with a shared `time` property.
public class InterpolationSet {

	var interpolations = [Timeable]()

	public init() { }

	public func append<I: Interpolable, P: PropertyProtocol>(_ interpolation: Interpolation<I, P>) {
		interpolations.append(interpolation)
	}

	public var time: Time = 0 {
		didSet {
			interpolations.forEach { (var timeable) in timeable.time = time }
		}
	}

	public func remove<I: Interpolable, P: PropertyProtocol>(_ interpolation: Interpolation<I, P>) {
		interpolations = interpolations.filter { ($0 as? Interpolation<I, P>) != interpolation }
	}

	public func removeAll() {
		interpolations.removeAll()
	}
}
