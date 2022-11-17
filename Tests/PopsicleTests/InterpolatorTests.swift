@testable import Popsicle
import XCTest

final class InterpolatorTests: XCTestCase {
    func test() {
        let view = UIView()
        XCTAssertEqual(view.center.x, 0)

        let sut = Interpolator()
        sut.setKeyframe(0) { view.center.x = 50 }
        sut.setKeyframe(100) { view.center.x = 100 }
        sut.setKeyframe(500) { view.center.x = 800 }

        XCTAssertEqual(view.center.x, 50)
//        sut.time = 50
    }
}
