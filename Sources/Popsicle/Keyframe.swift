import UIKit

struct Keyframe {
    var curve: UITimingCurveProvider
    var content: () -> Void

    init(curve: UITimingCurveProvider, content: @escaping () -> Void) {
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
