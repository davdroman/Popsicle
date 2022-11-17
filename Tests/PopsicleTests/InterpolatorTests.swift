@testable import Popsicle
import SnapshotTesting
import XCTest

final class InterpolatorTests: XCTestCase {
    func test() {
        let container = UIView(frame: .init(x: 0, y: 0, width: 1000, height: 1000))
        container.backgroundColor = .lightGray
        let view = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        container.addSubview(view)

//        XCTAssertEqual(view.center.x, 0)

        let sut = Interpolator()
        sut.setKeyframe(0) { view.center.x = 50 }
        sut.setKeyframe(100) { view.center.x = 100 }
        sut.setKeyframe(500) { view.center.x = 800 }

        RunLoop.main.run(until: Date() + 0.25)

//        assertSnapshot(matching: container, as: .image)

        XCTAssertEqual(view.center.x, 50)
        sut.time = 50

        XCTAssertEqual(view.center.x, 50)
        sut.time = 75

        XCTAssertEqual(view.center.x, 50)
        sut.time = 100

        XCTAssertEqual(view.center.x, 50)
        sut.time = 150
        XCTAssertEqual(view.center.x, 75)
    }
}
