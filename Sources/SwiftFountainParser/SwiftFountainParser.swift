import Foundation
import RegexBuilder

public struct SwiftFountainParser {
    public init() {
    }
    
    static func isHeading(text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: FNScreenplayElement.sceneHeading.rawValue)
        return regex.firstMatch(in: text, range: range) != nil
    }
    
    static func getElementType(text: String) -> FNScreenplayElement {
        let range = NSRange(location: 0, length: text.utf16.count)
        for element in FNScreenplayElement.allCases {
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
    
    static func createToken(text: String) -> FNScreenplayElementToken {
        switch getElementType(text: text) {
        case .titlePage:
            return FNTitlePage(text)
        case .sceneHeading:
            return FNSceneHeading(text)
        case .sceneNumber:
            return FNSceneNumber(text)
        case .transition:
            return FNTransition(text)
        case .dialogue:
            return FNDialogue(text)
        case .parenthetical:
            return FNParenthetical(text)
        case .action:
            return FNAction(text)
        case .centered:
            return FNCentered(text)
        case .section:
            return FNSection(text)
        case .synopsis:
            return FNSynopsis(text)
        case .note:
            return FNNote(text)
        case .noteInline:
            return FNNoteInline(text)
        case .boneyard:
            return FNBoneyard(text)
        case .pageBreak:
            return FNPageBreak(text)
        case .lineBreak:
            return FNLineBreak(text)
        case .emphasis:
            return FNEmphasis(text)
        case .boldItalicUnderline:
            return FNBoldItalicUnderline(text)
        case .boldUnderline:
            return FNBoldUnderline(text)
        case .italicUnderline:
            return FNItalicUnderline(text)
        case .boldItalic:
            return FNBoldItalic(text)
        case .bold:
            return FNBold(text)
        case .italic:
            return FNItalic(text)
        case .underline:
            return FNUnderline(text)
        }
    }
}
