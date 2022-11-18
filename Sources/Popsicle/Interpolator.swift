import UIKit

public typealias Keyframe = () -> Void
public typealias TimingCurve = UITimingCurveProvider

//typealias TimingCurves = Timeline<TimingCurve>

public final class Interpolator {
    public var time: Time = 0 {
        didSet { timeDidChange(time) }
    }

    var keyframes: Timeline<Keyframe> = [:]
//    var timingCurves: TimingCurves = [:]

    public init() {}

    public func setKeyframe(_ time: Time, _ keyframe: Keyframe?) {
        if time == self.time {
            keyframe?()
        }
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

        guard let (nextKeytime, nextKeyframe) = keyframes.next(after: time) else {
            return
        }

        if currentKeytime != latestKeytime {
            latestKeytime = currentKeytime

            animator?.stopAnimation(true)
//            if currentKeytime > (latestKeytime ?? 0) {
//                animator?.finishAnimation(at: .end)
//            } else {
//                animator?.finishAnimation(at: .start)
//            }
            currentKeyframe()
            animator = UIViewPropertyAnimator(duration: .zero, curve: .linear, animations: nextKeyframe)
            animator?.scrubsLinearly = false
        }

        let relativeTime = (time - currentKeytime) / (nextKeytime - currentKeytime)

        animator?.fractionComplete = relativeTime
    }

    deinit {
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .current)
        animator = nil
    }
}

//extension OrderedDictionary where Key == Time, Value == TimingCurve {
//    func timingCurve()
//}
