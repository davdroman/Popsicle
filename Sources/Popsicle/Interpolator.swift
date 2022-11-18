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
        if time == self.time, let keyframe = keyframe {
            DispatchQueue.main.async(execute: keyframe)
        }
        keyframes[time] = keyframe
    }

//    public func setKeyframe<Root: AnyObject, Value>(
//        _ time: Time,
//        _ root: Root,
//        _ keyPath: ReferenceWritableKeyPath<Root, Value>,
//        _ value: @autoclosure @escaping () -> Value
//    ) {
//        let keyframe = {
//            root[keyPath: keyPath] = value()
//        }
//        setKeyframe(0, keyframe)
//    }

//    public func setTimingCurve(_ time: Time, _ timingCurve: TimingCurve?) {
//        timingCurves[time] = timingCurve
//    }

    private var animator: UIViewPropertyAnimator?
    private var latestKeytime: Time?

    private func timeDidChange(_ time: Time) {
        guard
            keyframes.count >= 2,
            let initialTime = keyframes.initialTime,
            let finalTime = keyframes.finalTime
        else {
            return
        }

        let time = time.clamped(to: initialTime...finalTime)

        guard
            let (currentKeytime, currentKeyframe) = keyframes.current(for: time),
            let (nextKeytime, nextKeyframe) = keyframes.next(after: time)
        else {
            return
        }

        if currentKeytime != latestKeytime {
            animator?.stopAnimation(true)

            keyframes.allPrevious(before: currentKeytime).lazy.map(\.1)()
            currentKeyframe()

            animator = UIViewPropertyAnimator(duration: .zero, curve: .linear, animations: nextKeyframe)
            animator?.scrubsLinearly = false

            latestKeytime = currentKeytime
        }

        let relativeTime = (time - currentKeytime) / (nextKeytime - currentKeytime)
        animator?.fractionComplete = relativeTime
    }

    deinit {
        animator?.stopAnimation(true)
        animator = nil
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(range.lowerBound, self), range.upperBound)
    }
}

extension Collection {
    func callAsFunction() where Element == () -> Void {
        forEach { $0() }
    }
}
