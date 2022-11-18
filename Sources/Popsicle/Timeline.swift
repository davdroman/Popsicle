import SortedCollections

public typealias Time = Double

typealias Timeline<Value> = SortedDictionary<Time, Value>

extension Timeline where Key == Time {
    var initialTime: Time? {
        keys.first
    }

    var finalTime: Time? {
        keys.last
    }

    func current(for time: Time) -> (Time, Value)? {
        if let value = self[time] {
            return (time, value)
        }

        if let time = keys.lazy.reversed().first(where: { time >= $0 }), let value = self[time] {
            return (time, value)
        }

        return first
    }

    func next(after time: Time) -> (Time, Value)? {
        if let time = keys.first(where: { $0 > time }), let value = self[time] {
            return (time, value)
        }

        return last
    }

    func allPrevious(before time: Time) -> [(Time, Value)] {
        filter { $0.key < time }
    }
}
