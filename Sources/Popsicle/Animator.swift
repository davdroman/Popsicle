import Collections
import UIKit

public typealias Time = Double
public typealias Keyframe = () -> Void
public typealias TimingCurve = UITimingCurveProvider

typealias Timeline = OrderedDictionary<Time, Keyframe>
typealias TimingCurves = OrderedDictionary<Time, TimingCurve>

public final class Interpolator {
    public var time: Time = 0 {
        didSet { timeDidChange(time) }
    }

    var timeline: Timeline = [:]
    var timingCurves: TimingCurves = [:]

    public init() {}

    public func setKeyframe(_ time: Time, _ keyframe: @escaping Keyframe) {
        timeline[time] = keyframe
    }

    public func setTimingCurve(_ timingCurve: TimingCurve, at time: Time) {
        timingCurves[time] = timingCurve
    }

    private var animator: UIViewPropertyAnimator?
    private var latestKeytime: Time?

    private func timeDidChange(_ time: Time) {
        guard let totalTime = timeline.totalTime else {
            return
        }

        guard let (currentKeyframe, currentKeytime) = timeline.currentKeyframe(for: time) else {
            return
        }

        guard let (nextKeyframe, _) = timeline.nextKeyframe(for: time) else {
            return
        }

        if currentKeytime != latestKeytime {
            latestKeytime = currentKeytime

            animator?.stopAnimation(true)
            currentKeyframe()
            animator = UIViewPropertyAnimator(duration: .zero, curve: .linear, animations: nextKeyframe)
            animator?.scrubsLinearly = false
        }

        animator?.fractionComplete = time / totalTime
    }
}

extension Timeline {
    var totalTime: Time? {
        guard
            let initialTime = keys.first,
            let finalTime = keys.last,
            finalTime > initialTime
        else {
            return nil
        }
        return finalTime - initialTime
    }

    func currentKeyframe(for time: Time) -> (keyframe: Keyframe, keytime: Time)? {
        if let keyframe = self[time] {
            return (keyframe, time)
        }

        if let time = keys.first(where: { time >= $0 }), let keyframe = self[time] {
            return (keyframe, time)
        }

        if let (time, keyframe) = self.elements.first {
            return (keyframe, time)
        }

        return nil
    }

    func nextKeyframe(for time: Time) -> (keyframe: Keyframe, keytime: Time)? {
        return nil
//        if let value = self[time] {
//            return (value, time)
//        }
//
//        if let time = keys.first(where: { time >= $0 }) {
//            return self[time]
//        }
//
//        return self.values.first
    }
}

//extension OrderedDictionary where Key == Time, Value == TimingCurve {
//    func timingCurve()
//}
