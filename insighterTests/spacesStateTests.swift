import Foundation

@testable import insighter
import XCTest

enum MyError: Error, Equatable {
    case someExpectedError
    case someUnexpectedError
    case associatedValueError(value: Int)
}

class spacesStateTests: XCTestCase {
    func test_GivenConfigFileDoesNotExist_WhenReading_ThenThrows() {
        let url = URL(fileURLWithPath: "i-do-not.exist")
        XCTAssertThrowsError(try _readSpacesPlist(url: url)) {
            e in XCTAssertEqual((e as NSError).domain, NSCocoaErrorDomain)
        }
    }

    func test_GivenConfigFile_WhenReading_ThenFieldsAreCorrect() {
        let path = "/Users/brunoroque/Projects/insighter/insighterTests/com.apple.spaces.plist"
        let url = URL(fileURLWithPath: path)
        let spaces = try! _readSpacesPlist(url: url)

        XCTAssertEqual(spaces.spacesDisplayConfiguration.managementData.monitors[0].currentSpace?.uuid, "8C5D0BD7-D0F2-49AB-821F-C73507C21853")
        XCTAssertEqual(spaces.spacesDisplayConfiguration.spaceProperties.count, 3)
    }
}
