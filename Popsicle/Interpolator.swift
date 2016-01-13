//
//  Interpolator.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// Value type on which interpolation values rely on.
public typealias Time = Double

/// `Interpolator` collects and coordinates a set of related interpolations through its `time` property.
public class Interpolator {
	var interpolations = [Timeable]()

	public init() {}

	public func addInterpolation<T: Interpolable>(interpolation: Interpolation<T>) {
		self.interpolations.append(interpolation)
	}

	public var time: Time = 0 {
		didSet {
			for interpolation in self.interpolations {
                if let interpolation = interpolation as? Interpolation<CGFloat> {
                    if interpolation.keyPath == "constant" && (interpolation.object as? NSLayoutConstraint)?.firstAttribute == .Width {
                        print((interpolation.object as? NSLayoutConstraint))
                        print((interpolation.originalObject as? UIView)?.constraints)
                        //(interpolation.originalObject as? UIView)?.layoutIfNeeded()
                    }
                }
				interpolation.setTime(self.time)
			}
		}
	}

	public func removeInterpolation<T: Interpolable>(interpolation: Interpolation<T>) {
		for (index, element) in self.interpolations.enumerate() {
			if let interpolation = element as? Interpolation<T> {
				if interpolation == interpolation {
					self.interpolations.removeAtIndex(index)
				}
			}
		}
	}

	/// Removes all interpolations containing the specified object.
	public func removeInterpolations(forObject object: NSObject) {
		for (index, element) in self.interpolations.enumerate() {
			if let interpolation = element as? ObjectReferable {
				if interpolation.objectReference == object {
					self.interpolations.removeAtIndex(index)
					self.removeInterpolations(forObject: object) // Recursivity FTW
					return
				}
			}
		}
	}

	public func removeAllInterpolations() {
		self.interpolations.removeAll()
	}
}