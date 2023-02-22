import XCTest
@testable import SwiftFountainParser

final class SwiftFountainParserTests: XCTestCase {
    
    func testSceneHeadingRegex() throws {
        XCTAssertEqual(SwiftFountainParser.parseElement(text: "INT. BEDROOM - DAY"), .sceneHeading)
        XCTAssertEqual(SwiftFountainParser.parseElement(text: "int./ext. bedroom - day"), .sceneHeading)
        XCTAssertEqual(SwiftFountainParser.parseElement(text: "ext yard night"), .sceneHeading)
    }
    
    func testActionRegex() throws {
        XCTAssertEqual(SwiftFountainParser.parseElement(text: "Andy sits and ponders."), .action)
        XCTAssertEqual(SwiftFountainParser.parseElement(text: "==="), .pageBreak)
    }
}
