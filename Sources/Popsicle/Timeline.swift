import Collections

public typealias Time = Double

typealias Timeline<Value> = OrderedDictionary<Time, Value>

extension Timeline where Key == Time {
    var initialTime: Time? {
        self.elements.first?.key
    }

    var finalTime: Time? {
        self.elements.last?.key
    }

    func current(for time: Time) -> (Time, Value)? {
        if let value = self[time] {
            return (time, value)
        }

        if let time = keys.lazy.reversed().first(where: { time >= $0 }), let value = self[time] {
            return (time, value)
        }

        return self.elements.first
    }

    func next(after time: Time) -> (Time, Value)? {
        if let time = keys.first(where: { $0 > time }), let value = self[time] {
            return (time, value)
        }

        return self.elements.last
    }

    func allPrevious(before time: Time) -> [(Time, Value)] {
        self.elements.filter { $0.key < time }
    }
}
