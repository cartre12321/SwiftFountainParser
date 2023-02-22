import XCTest
@testable import SwiftFountainParser

final class SwiftFountainParserTests: XCTestCase {
    
    func testSceneHeadingRegex() throws {
        XCTAssertEqual(SwiftFountainParser.getElementType(text: "INT. BEDROOM - DAY"), .sceneHeading)
        XCTAssertEqual(SwiftFountainParser.getElementType(text: "int./ext. bedroom - day"), .sceneHeading)
        XCTAssertEqual(SwiftFountainParser.getElementType(text: "ext yard night"), .sceneHeading)
    }
    
    func testActionRegex() throws {
        XCTAssertEqual(SwiftFountainParser.getElementType(text: "Andy sits and ponders."), .action)
        XCTAssertEqual(SwiftFountainParser.getElementType(text: "==="), .pageBreak)
    }
    
    func textCreateToken() throws {
        XCTAssertEqual(SwiftFountainParser.createToken(text: "title: Screenplay Title").type, .titlePage)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "INT. BEDROOM - DAY").type, .sceneHeading)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "#1#").type, .sceneNumber)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "CUT TO:").type, .transition)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "CARTER\nThis is going to be good").type, .dialogue)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "(softly)").type, .parenthetical)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "He walked across the room.").type, .action)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "title: Screenplay Title").type, .centered)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "# Act 1").type, .section)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "= Events begin to unfold").type, .synopsis)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "[[A note]]").type, .note)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "Some stuff [[inline note]] more stuff").type, .noteInline)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "/* This goes in the boneyard */").type, .boneyard)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "===").type, .pageBreak)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "  ").type, .lineBreak)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "**emphasis**").type, .emphasis)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "_***bold italic underline***_").type, .boldItalicUnderline)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "_**bold underline **_").type, .boldUnderline)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "_*italic underline*_").type, .italicUnderline)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "***bold italic***").type, .boldItalic)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "**bold**").type, .bold)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "*italic*").type, .italic)
        XCTAssertEqual(SwiftFountainParser.createToken(text: "_underlined_").type, .underline)
    }
}
