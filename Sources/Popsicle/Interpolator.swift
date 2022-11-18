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
        _ content: @escaping Keyframe.Content
    ) {
        addKeyframe(time, UICubicTimingParameters(animationCurve: curve), content)
    }

    public func addKeyframe(
        _ time: Time,
        _ curve: UITimingCurveProvider,
        _ content: @escaping Keyframe.Content
    ) {
        let keyframe = Keyframe(curve: curve, content: content)
        if time == self.time {
            DispatchQueue.main.async { keyframe() }
        }
        keyframes[time, default: []].append(keyframe)
    }

//    public subscript(time: Time) -> [Keyframe] {
//        _read { yield keyframes[time, default: []] }
//        _modify { yield &keyframes[time, default: []] }
//    }

    private func timeDidChange(_ time: Time) {
        guard
            keyframes.count >= 2,
            let (currentKeytime, currentKeyframe) = keyframes.current(for: time)
        else {
            return
        }

        let previousKeyframes = keyframes.allPrevious(before: currentKeytime).lazy.flatMap(\.1)
        let nextKeyframes = keyframes.next(after: time)

        DispatchQueue.main.async {
            previousKeyframes()
            currentKeyframe()

            if let (nextKeytime, nextKeyframe) = nextKeyframes {
                let relativeTime = (time - currentKeytime) / (nextKeytime - currentKeytime)
                nextKeyframe(relativeTime)
            }
        }

    }
}

extension Collection where Element == Keyframe {
    func callAsFunction(_ time: Time? = nil) {
        forEach { $0(time) }
    }
}
