@testable import Popsicle
import XCTest

final class InterpolatorTests: XCTestCase {
    func test() throws {
        let view = UIView()
        UIWindow().addSubview(view) // makes presentation layers behave as expected

        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 0)
        }

        let sut = Interpolator()
        sut.setKeyframe(0) {
            view.frame.origin.x = 100
            view.alpha = 0
        }
        sut.setKeyframe(100) {
            view.frame.origin.x = 200
            view.alpha = 0.5
        }
        sut.setKeyframe(200) {
            view.frame.origin.x = 300
            // no alpha
        }
        sut.setKeyframe(400) {
            view.frame.origin.x = 1000
            view.alpha = 1
        }
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 100, accuracy: 0.0001)
            XCTAssertEqual($0.opacity, 0, accuracy: 0.0001)
        }

        let assertions: [() throws -> Void] = [
            {
                sut.time = 50
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 150, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.25, accuracy: 0.0001)
                }
            },
            {
                sut.time = 100
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 200, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.5, accuracy: 0.0001)
                }
            },
            {
                sut.time = 150
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 250, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.5, accuracy: 0.0001)
                }
            },
            {
                sut.time = 300
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 650, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.75, accuracy: 0.0001)
                }
            },
            {
                sut.time = 400
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 1, accuracy: 0.0001)
                }
            },
            {
                sut.time = 1000
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 1, accuracy: 0.0001)
                }
            },
            {
                sut.time = 400
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 1, accuracy: 0.0001)
                }
            },
            {
                sut.time = 300
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 650, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.75, accuracy: 0.0001)
                }
            },
            {
                sut.time = 50
                try view.assertOnPresentationLayer {
                    XCTAssertEqual($0.frame.origin.x, 150, accuracy: 0.0001)
                    XCTAssertEqual($0.opacity, 0.25, accuracy: 0.0001)
                }
            },
        ]

        try assertions.shuffled()()
    }
}

extension UIView {
    func assertOnPresentationLayer(
        _ assertions: (CALayer) -> Void,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Void {
        RunLoop.main.run(until: Date())
        let layer = try XCTUnwrap(self.layer.presentation(), file: file, line: line)
        assertions(layer)
    }
}

extension Collection {
    func callAsFunction() throws where Element == () throws -> Void {
        try forEach { try $0() }
    }
}
