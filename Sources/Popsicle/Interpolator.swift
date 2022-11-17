import Collections
import UIKit

//typealias TimingCurves = OrderedDictionary<Time, TimingCurve>

public final class Interpolator {
    public var time: Time = 0 {
        didSet { timeDidChange(time) }
    }

    var keyframes: Timeline<Keyframe> = [:]
//    var timingCurves: TimingCurves = [:]

    public init() {}

    public func setKeyframe(_ time: Time, _ keyframe: Keyframe?) {
        keyframes[time] = keyframe
    }

//    public func setTimingCurve(_ time: Time, _ timingCurve: TimingCurve?) {
//        timingCurves[time] = timingCurve
//    }

    private var animator: UIViewPropertyAnimator?
    private var latestKeytime: Time?

    private func timeDidChange(_ time: Time) {
        guard keyframes.count >= 2 else {
            return
        }

        guard let (currentKeytime, currentKeyframe) = keyframes.current(for: time) else {
            return
        }

        guard let (nextKeytime, nextKeyframe) = keyframes.next(for: time) else {
            return
        }

        if currentKeytime != latestKeytime {
            latestKeytime = currentKeytime

            animator?.stopAnimation(true)
            currentKeyframe()
            animator = UIViewPropertyAnimator(duration: .zero, curve: .linear, animations: nextKeyframe)
            animator?.scrubsLinearly = false
        }

        let relativeTime = (time - currentKeytime) / (nextKeytime - currentKeytime)

        animator?.fractionComplete = relativeTime
    }
}

//extension OrderedDictionary where Key == Time, Value == TimingCurve {
//    func timingCurve()
//}
