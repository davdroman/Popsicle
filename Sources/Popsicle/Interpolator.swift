import UIKit

public final class Interpolator {
    public var time: Time = 0 {
        didSet { timeDidChange(time) }
    }

    var keyframes: Timeline<[Keyframe]> = [:]

    public init() {}

    public func addKeyframe(
        _ time: Time,
        _ curve: UIView.AnimationCurve = .linear,
        _ content: @escaping () -> Void
    ) {
        addKeyframe(time, UICubicTimingParameters(animationCurve: curve), content)
    }

    public func addKeyframe(
        _ time: Time,
        _ curve: UITimingCurveProvider,
        _ content: @escaping () -> Void
    ) {
        let keyframe = Keyframe(curve: curve, content: content)
        if time == self.time {
            keyframe()
        }
        keyframes[time, default: []].append(keyframe)
    }

    private func timeDidChange(_ time: Time) {
        guard
            keyframes.count >= 2,
            let (currentKeytime, currentKeyframe) = keyframes.current(for: time)
        else {
            return
        }

        keyframes.allPrevious(before: currentKeytime).lazy.flatMap(\.1)()
        currentKeyframe()

        if let (nextKeytime, nextKeyframe) = keyframes.next(after: time) {
            let relativeTime = (time - currentKeytime) / (nextKeytime - currentKeytime)
            nextKeyframe(relativeTime)
        }
    }
}

extension Collection where Element == Keyframe {
    func callAsFunction(_ time: Time? = nil) {
        forEach { $0(time) }
    }
}
