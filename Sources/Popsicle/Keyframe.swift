import UIKit

public struct Keyframe {
    public typealias Content = () -> Void

    var curve: UITimingCurveProvider
    var content: Content

    init(curve: UITimingCurveProvider, content: @escaping Content) {
        self.curve = curve
        self.content = content
    }

    func callAsFunction(_ time: Time? = nil) {
        if let time = time {
            let animator = UIViewPropertyAnimator(duration: .zero, timingParameters: curve)
            animator.addAnimations(content)
            animator.scrubsLinearly = false
            animator.fractionComplete = time
            DispatchQueue.main.async {
                animator.stopAnimation(true)
            }
        } else {
            content()
        }
    }
}
