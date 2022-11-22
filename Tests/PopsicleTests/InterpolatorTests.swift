@testable import Popsicle
import XCTest

final class InterpolatorTests: XCTestCase {
    func test() throws {
        let view = UIView()
        UIWindow().addSubview(view) // makes presentation layers behave as expected

        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 0)
            XCTAssertEqual($0.opacity, 1, accuracy: 0.0001)
        }

        let sut = Interpolator()
        sut.addKeyframe(0) {
            view.frame.origin.x = 100
            view.alpha = 0
        }
        sut.addKeyframe(100) {
            view.frame.origin.x = 200
            view.alpha = 0.5
        }
        sut.addKeyframe(200) {
            view.frame.origin.x = 300
            // no alpha
        }
        sut.addKeyframe(400) {
            view.frame.origin.x = 1000
            view.alpha = 1
        }

        let assertions: [() throws -> Void] = [
            {
                sut(-100)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 100, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0, accuracy: 0.0001)
                }
            },
            {
                sut(0)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 100, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0, accuracy: 0.0001)
                }
            },
            {
                sut(50)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 150, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.25, accuracy: 0.0001)
                }
            },
            {
                sut(100)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 200, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.5, accuracy: 0.0001)
                }
            },
            {
                sut(150)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 250, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.5, accuracy: 0.0001)
                }
            },
            {
                sut(300)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 650, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.75, accuracy: 0.0001)
                }
            },
            {
                sut(400)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 1, accuracy: 0.0001)
                }
            },
            {
                sut(1200)
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 1, accuracy: 0.0001)
                }
            },
        ]

        var rng = WyRand()
        try Array(repeating: assertions, count: 5).flatMap { $0 }.shuffled(using: &rng)()
    }
}

extension UIView {
    func assertOnPresentationLayer(
        _ assertions: (CALayer) -> Void,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Void {
        RunLoop.main.run(until: Date() + 0.1)
        let layer = try XCTUnwrap(self.layer.presentation(), file: file, line: line)
        assertions(layer)
    }
}

struct WyRand: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64 = .random(in: 0...100000)) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0xa0761d6478bd642f
        let mul = state.multipliedFullWidth(by: state ^ 0xe7037ed1a0b428db)
        return mul.high ^ mul.low
    }
}


extension Collection where Element == () throws -> Void {
    func callAsFunction() throws {
        try forEach { try $0() }
    }
}
