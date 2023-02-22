import Foundation
import RegexBuilder

public struct SwiftFountainParser {
    public init() {
    }
    
    static func isHeading(text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: ScreenplayElement.sceneHeading.rawValue)
        return regex.firstMatch(in: text, range: range) != nil
    }
    
    static func parseElement(text: String) -> ScreenplayElement {
        let range = NSRange(location: 0, length: text.utf16.count)
        for element in ScreenplayElement.allCases {
            guard element != .action else {
                continue
            }
            let regex = try! NSRegularExpression(pattern: element.rawValue)
            if (regex.firstMatch(in: text, range: range) != nil) {
                return element
            }
        }
        return .action
    }
}
