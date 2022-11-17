@testable import Popsicle
import XCTest

final class TimelineTests: XCTestCase {
    let sut: Timeline<Character> = [
        0: "a",
        250: "b",
        500: "c",
        750: "d",
        1000: "e",
    ]

    func testCurrent() {
        XCTAssert(sut.current(for: -.greatestFiniteMagnitude)! == (0, "a"))
        XCTAssert(sut.current(for: -1)! == (0, "a"))
        XCTAssert(sut.current(for: 0)! == (0, "a"))
        XCTAssert(sut.current(for: 1)! == (0, "a"))

        XCTAssert(sut.current(for: 249)! == (0, "a"))
        XCTAssert(sut.current(for: 250)! == (250, "b"))
        XCTAssert(sut.current(for: 251)! == (250, "b"))

        XCTAssert(sut.current(for: 499)! == (250, "b"))
        XCTAssert(sut.current(for: 500)! == (500, "c"))
        XCTAssert(sut.current(for: 501)! == (500, "c"))

        XCTAssert(sut.current(for: 749)! == (500, "c"))
        XCTAssert(sut.current(for: 750)! == (750, "d"))
        XCTAssert(sut.current(for: 751)! == (750, "d"))

        XCTAssert(sut.current(for: 999)! == (750, "d"))
        XCTAssert(sut.current(for: 1000)! == (1000, "e"))
        XCTAssert(sut.current(for: 1001)! == (1000, "e"))
        XCTAssert(sut.current(for: .greatestFiniteMagnitude)! == (1000, "e"))
    }

    func testNext() {
        XCTAssert(sut.next(for: -.greatestFiniteMagnitude)! == (0, "a"))
        XCTAssert(sut.next(for: -1)! == (0, "a"))
        XCTAssert(sut.next(for: 0)! == (250, "b"))
        XCTAssert(sut.next(for: 1)! == (250, "b"))

        XCTAssert(sut.next(for: 249)! == (250, "b"))
        XCTAssert(sut.next(for: 250)! == (500, "c"))
        XCTAssert(sut.next(for: 251)! == (500, "c"))

        XCTAssert(sut.next(for: 499)! == (500, "c"))
        XCTAssert(sut.next(for: 500)! == (750, "d"))
        XCTAssert(sut.next(for: 501)! == (750, "d"))

        XCTAssert(sut.next(for: 749)! == (750, "d"))
        XCTAssert(sut.next(for: 750)! == (1000, "e"))
        XCTAssert(sut.next(for: 751)! == (1000, "e"))

        XCTAssert(sut.next(for: 999)! == (1000, "e"))
        XCTAssert(sut.next(for: 1000)! == (1000, "e"))
        XCTAssert(sut.next(for: 1001)! == (1000, "e"))
        XCTAssert(sut.next(for: .greatestFiniteMagnitude)! == (1000, "e"))
    }
}
