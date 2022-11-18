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

    public func addKeyframe(_ time: Time, _ keyframe: @escaping Keyframe) {
        if time == self.time {
            DispatchQueue.main.async(execute: keyframe)
        }
        let existingKeyframe = keyframes[time]
        keyframes[time] = {
            existingKeyframe?()
            keyframe()
        }
    }

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
