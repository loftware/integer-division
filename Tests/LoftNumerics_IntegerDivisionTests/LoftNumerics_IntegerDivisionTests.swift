import XCTest
@testable import LoftNumerics_IntegerDivision

final class LoftNumerics_IntegerDivisionTests: XCTestCase {
    func fuzzDivision(
        name: String,
        dividends: ClosedRange<Int>,
        divisors: ClosedRange<Int>,
        _ testing: (Int, Int) -> Int,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        for a in dividends {
            for b in divisors {
                if b == 0 { continue }
                XCTAssertEqual(testing(a, b), a / b, """
                    \(a).\(name)(\(b)) was \(testing(a, b)), expected \(a/b)
                    """, file: file, line: line)
            }
        }
    }

    func testFlooringDivNormalDivision() {
        fuzzDivision(
            name: "flooringDiv",
            dividends: 0...1000,
            divisors: 1...1000
        ) {
            $0.flooringDiv($1)
        }
        fuzzDivision(
            name: "flooringDiv",
            dividends: (-1000)...(-1),
            divisors: (-1000)...(-1)
        ) {
            $0.flooringDiv($1)
        }
    }

    func testCeilingDivNormalDivision() {
        fuzzDivision(
            name: "ceilingDiv",
            dividends: 0...1000,
            divisors: (-1000)...(-1)
        ) {
            $0.ceilingDiv($1)
        }
        fuzzDivision(
            name: "ceilingDiv",
            dividends: (-1000)...(-1),
            divisors: 1...1000
        ) {
            $0.ceilingDiv($1)
        }
    }

    func testFlooringDivNegativeResult() {
        XCTAssertEqual((-6).flooringDiv(2), -3)
        XCTAssertEqual(6.flooringDiv(-2), -3)
        XCTAssertEqual((-5).flooringDiv(2), -3)
        XCTAssertEqual(5.flooringDiv(-2), -3)
        XCTAssertEqual(1.flooringDiv(-2), -1)
    }

    func testCeilingDivPositiveResult() {
        XCTAssertEqual(6.ceilingDiv(2), 3)
        XCTAssertEqual((-6).ceilingDiv(-2), 3)
        XCTAssertEqual(5.ceilingDiv(2), 3)
        XCTAssertEqual((-5).ceilingDiv(-2), 3)
        XCTAssertEqual(1.ceilingDiv(2), 1)
    }

    static var allTests = [
        ("testFlooringDivNormalDivision", testFlooringDivNormalDivision),
        ("testCeilingDivNormalDivision", testCeilingDivNormalDivision),
        ("testFlooringDivNegativeResult", testFlooringDivNegativeResult),
        ("testCeilingDivPositiveResult", testCeilingDivPositiveResult),
    ]
}
