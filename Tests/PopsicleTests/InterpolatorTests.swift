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
        }
        sut.setKeyframe(100) {
            view.frame.origin.x = 200
        }
        sut.setKeyframe(200) {
            view.frame.origin.x = 300
        }
        sut.setKeyframe(600) {
            view.frame.origin.x = 1000
        }
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 100, accuracy: 0.0001)
        }

        sut.time = 50
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 150, accuracy: 0.0001)
        }

        sut.time = 100
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 200, accuracy: 0.0001)
        }

        sut.time = 150
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 250, accuracy: 0.0001)
        }

        sut.time = 300
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 475, accuracy: 0.0001)
        }

        sut.time = 600
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
        }

        sut.time = 1000
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
        }

        sut.time = 600
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 1000, accuracy: 0.0001)
        }

        sut.time = 300
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 475, accuracy: 0.0001)
        }

        sut.time = 0
        try view.assertOnPresentationLayer {
            XCTAssertEqual($0.frame.origin.x, 100, accuracy: 0.0001)
        }
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
