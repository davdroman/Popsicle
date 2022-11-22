// Adapted from https://gist.github.com/muukii/f79d44b13db2a2004ac091352a3c0b04

import UIKit

extension UITimingCurveProvider where Self == UICubicTimingParameters {
    static var easeInSine: Self { .init(0.47, 0, 0.745, 0.715) }
    static var easeOutSine: Self { .init(0.39, 0.575, 0.565, 1) }
    static var easeInOutSine: Self { .init(0.445, 0.05, 0.55, 0.95) }
    static var easeInQuad: Self { .init(0.55, 0.085, 0.68, 0.53) }
    static var easeOutQuad: Self { .init(0.25, 0.46, 0.45, 0.94) }
    static var easeInOutQuad: Self { .init(0.455, 0.03, 0.515, 0.955) }
    static var easeInCubic: Self { .init(0.55, 0.055, 0.675, 0.19) }
    static var easeOutCubic: Self { .init(0.215, 0.61, 0.355, 1) }
    static var easeInOutCubic: Self { .init(0.645, 0.045, 0.355, 1) }
    static var easeInQuart: Self { .init(0.895, 0.03, 0.685, 0.22) }
    static var easeOutQuart: Self { .init(0.165, 0.84, 0.44, 1) }
    static var easeInOutQuart: Self { .init(0.77, 0, 0.175, 1) }
    static var easeInQuint: Self { .init(0.755, 0.05, 0.855, 0.06) }
    static var easeOutQuint: Self { .init(0.23, 1, 0.32, 1) }
    static var easeInOutQuint: Self { .init(0.86, 0, 0.07, 1) }
    static var easeInExpo: Self { .init(0.95, 0.05, 0.795, 0.035) }
    static var easeOutExpo: Self { .init(0.19, 1, 0.22, 1) }
    static var easeInOutExpo: Self { .init(1, 0, 0, 1) }
    static var easeInCirc: Self { .init(0.6, 0.04, 0.98, 0.335) }
    static var easeOutCirc: Self { .init(0.075, 0.82, 0.165, 1) }
    static var easeInOutCirc: Self { .init(0.785, 0.135, 0.15, 0.86) }
    static var easeInBack: Self { .init(0.6, -0.28, 0.735, 0.045) }
    static var easeOutBack: Self { .init(0.175, 0.885, 0.32, 1.275) }
    static var easeInOutBack: Self { .init(0.68, -0.55, 0.265, 1.55) }
}

fileprivate extension UICubicTimingParameters {
    convenience init(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        self.init(controlPoint1: .init(x: x1, y: y1), controlPoint2: .init(x: x2, y: y2))
    }
}
