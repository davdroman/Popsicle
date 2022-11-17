@testable import Popsicle
import XCTest

final class TimelineTests: XCTestCase {
    func test() {
        let sut: Timeline<Character> = [
            0: "a",
            250: "b",
            500: "c",
            750: "d",
            1000: "e",
        ]
        XCTAssert(sut.current(for: -10)! == (0, "a"))
    }
}
