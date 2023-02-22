import XCTest
@testable import SwiftFountainParser

final class SwiftFountainParserTests: XCTestCase {
    
    func testRegexes() throws {
        let blah = """
        INT. BEDROOM - DAY
        
        Carter sits at his computer.
        
        CARTER
        This is great.
        """
        
        XCTAssertNotNil(blah.firstMatch(regex: FountainTokenType.sceneHeading.regex))
        XCTAssertNotNil(blah.firstMatch(regex: FountainTokenType.action.regex))
        XCTAssertNotNil(blah.firstMatch(regex: FountainTokenType.dialogue.regex))
        print(blah.firstMatch(regex: FountainTokenType.sceneHeading.regex)!)
        print(blah.firstMatch(regex: FountainTokenType.action.regex)!)
        print(blah.firstMatch(regex: FountainTokenType.dialogue.regex)!)
        
    }
}
