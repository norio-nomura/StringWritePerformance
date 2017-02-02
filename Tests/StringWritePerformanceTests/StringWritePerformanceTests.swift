import WrittenInObjC
import WrittenInSwift

import XCTest

class StringWritePerformanceTests: XCTestCase {
    let handle = fopen("/dev/null", "w")!
    let string = try! String(repeating: String(contentsOf: URL(fileURLWithPath: #file)), count: 100000 )

    override func setUp() {
        print("utf16.count: \(string.utf16.count)")
    }

    // MARK: - Use `String.data(using: .utf16)`
    func test_write2() {
        self.measure {
            try! write2(value: self.string, handle: self.handle)
        }
    }

    // MARK: - Use `NSString.getCharacters(_:)`
    func test_write3() {
        self.measure {
            try! write3(value: self.string, handle: self.handle)
        }
    }

    // MARK: - Use `-[NSString getCharacters:]`
    func test_writeNSString() {
        self.measure {
            writeNSString(self.handle, self.string)
        }
    }
}

extension StringWritePerformanceTests {
    static var allTests: [(String, (StringWritePerformanceTests) -> () throws -> Void)] {
        return [
            ("test_write2", test_write2),
            ("test_write3", test_write3),
            ("test_writeNSString", test_writeNSString),
        ]
    }
}
