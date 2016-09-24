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

	public func append<T: Interpolable>(_ interpolation: Interpolation<T>) {
		self.interpolations.append(interpolation)
	}

	public var time: Time = 0 {
		didSet {
			self.interpolations.forEach { (var timeable) in timeable.time = self.time }
		}
	}

	public func remove<T: Interpolable>(_ interpolation: Interpolation<T>) {
		for (index, element) in self.interpolations.enumerated() {
			if let interpolation = element as? Interpolation<T> {
				if interpolation == interpolation {
					self.interpolations.remove(at: index)
				}
			}
		}
	}

	public func removeAll() {
		self.interpolations.removeAll()
	}
}
