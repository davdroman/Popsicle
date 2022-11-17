import Collections

typealias Timeline<Value> = OrderedDictionary<Time, Value>

extension Timeline where Key == Time {
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
}
