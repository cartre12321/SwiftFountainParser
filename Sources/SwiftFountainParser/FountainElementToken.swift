//
//  FountainScreenplayElementToken.swift
//  
//
//  Created by Carter Riddall on 2023-02-21.
//

import Foundation



public enum FountainElementToken: Equatable, CaseIterable {
    
    case titlePage(text: String, children: [FountainElementToken]? = nil)
    
    case sceneHeading(text: String, children: [FountainElementToken]? = nil)
    case sceneNumber(text: String)
    
    case dialogue(text: String, children: [FountainElementToken]? = nil)
    case parenthetical(text: String, children: [FountainElementToken]? = nil)
    
    case action(text: String, children: [FountainElementToken]? = nil)
    case centered(text: String, children: [FountainElementToken]? = nil)
    
    case transition(text: String)
    
    case section(text: String, children: [FountainElementToken]? = nil)
    case synopsis(text: String, children: [FountainElementToken]? = nil)
    
    case note(text: String, children: [FountainElementToken]? = nil)
    case inlineNote(text: String, children: [FountainElementToken]? = nil)
    case boneyard(text: String, children: [FountainElementToken]? = nil)
    
    case pageBreak
    case lineBreak
    
    case emphasis(text: String, style: FountainEmphasisStyle)
    
    internal var regex: NSRegularExpression {
        switch self {
        case .titlePage:
            return try! NSRegularExpression(pattern: #"^(?i)((?:title|credit|author[s]?|source|notes|draft date|date|contact|copyright)\:)"#)
        case .sceneHeading:
            return try! NSRegularExpression(pattern: #"^(?i)((?:\*{0,3}_?)?(?:(?:int|ext|est|i\/e)[. ]).+)|^(?:\.(?!\.+))(.+)"#)
        case .sceneNumber:
            return try! NSRegularExpression(pattern: #"( *#(.+)# *)"#)
        case .dialogue:
            return try! NSRegularExpression(pattern: #"^([A-Z*_]+[0-9A-Z (._\-')]*)(\^?)?(?:\n(?!\n+))([\s\S]+)"#)
        case .parenthetical:
            return try! NSRegularExpression(pattern: #"^(\(.+\))$"#)
        case .action:
            return try! NSRegularExpression(pattern: #"^(.+)"#)
        case .centered:
            return try! NSRegularExpression(pattern: #"^(?:> *)(.+)(?: *<)(\n.+)*"#)
        case .transition:
            return try! NSRegularExpression(pattern: #"^((?:FADE (?:TO BLACK|OUT)|CUT TO BLACK)\.|.+ TO\:)|^(?:> *)(.+)"#)
        case .section:
            return try! NSRegularExpression(pattern: #"^(#+)(?: *)(.*)"#)
        case .synopsis:
            return try! NSRegularExpression(pattern: #"^(?:\=(?!\=+) *)(.*)"#)
        case .note:
            return try! NSRegularExpression(pattern: #"^(?:\[{2}(?!\[+))(.+)(?:\]{2}(?!\[+))$"#)
        case .inlineNote:
            return try! NSRegularExpression(pattern: #"(?:\[{2}(?!\[+))([\s\S]+?)(?:\]{2}(?!\[+))"#)
        case .boneyard:
            return try! NSRegularExpression(pattern: #"(^\/\*|^\*\/)$"#)
        case .pageBreak:
            return try! NSRegularExpression(pattern: #"^\={3,}$"#)
        case .lineBreak:
            return try! NSRegularExpression(pattern: #"^ {2}$"#)
        case .emphasis(text: _, style: let style):
            return style.regex
        }
    }
    
    func generateElement() -> FountainElement {
        switch self {
        case .titlePage(let text, _):
            return FountainTitlePage(content: text)
        case .sceneHeading(let text, _):
            return FountainSceneHeading(content: text)
        case .sceneNumber(let text):
            return FountainSceneNumber(content: text)
        case .dialogue(let text, _):
            return FountainDialogue(content: text)
        case .parenthetical(let text, _):
            return FountainParenthetical(content: text)
        case .action(let text, _):
            return FountainAction(content: text)
        case .centered(let text, _):
            return FountainCentered(content: text)
        case .transition(let text):
            return FountainTransition(content: text)
        case .section(let text, _):
            return FountainSection(content: text)
        case .synopsis(let text, _):
            return FountainSynopsis(content: text)
        case .note(let text, _):
            return FountainNote(content: text)
        case .inlineNote(let text, _):
            return FountainInlineNote(content: text)
        case .boneyard(let text, _):
            return FountainBoneyard(content: text)
        case .pageBreak:
            return FountainPageBreak()
        case .lineBreak:
            return FountainLineBreak()
        case .emphasis(let text, style: let style):
            switch style {
            case .boldItalicUnderline:
                return FountainBoldItalicUnderline(content: text)
            case .boldUnderline:
                return FountainBoldUnderline(content: text)
            case .italicUnderline:
                return FountainItalicUnderline(content: text)
            case .boldItalic:
                return FountainBoldItalic(content: text)
            case .bold:
                return FountainBold(content: text)
            case .italic:
                return FountainItalic(content: text)
            case .underline:
                return FountainUnderline(content: text)
            }
        }
    }
    
    public var content: String {
        switch self {
        case .titlePage(let text, _):
            return text
        case .sceneHeading(let text, _):
            return text
        case .sceneNumber(let text):
            return text
        case .dialogue(let text, _):
            return text
        case .parenthetical(let text, _):
            return text
        case .action(let text, _):
            return text
        case .centered(let text, _):
            return text
        case .transition(let text):
            return text
        case .section(let text, _):
            return text
        case .synopsis(let text, _):
            return text
        case .note(let text, _):
            return text
        case .inlineNote(let text, _):
            return text
        case .boneyard(let text, _):
            return text
        case .pageBreak:
            return "==="
        case .lineBreak:
            return "  "
        case .emphasis(let text, _):
            return text
        }
    }
    
    public var canBeBlock: Bool {
        switch self {
        case .titlePage:
            return true
        case .sceneHeading:
            return true
        case .sceneNumber:
            return false
        case .dialogue:
            return true
        case .parenthetical:
            return false
        case .action:
            return true
        case .centered:
            return true
        case .transition:
            return true
        case .section:
            return true
        case .synopsis:
            return true
        case .note:
            return true
        case .inlineNote:
            return false
        case .boneyard:
            return true
        case .pageBreak:
            return true
        case .lineBreak:
            return false
        case .emphasis:
            return false
        }
    }
    
    public var canBeLine: Bool {
        switch self {
        case .titlePage:
            return true
        case .sceneHeading:
            return false
        case .sceneNumber:
            return false
        case .dialogue:
            return false
        case .parenthetical:
            return true
        case .action:
            return false
        case .centered:
            return true
        case .transition:
            return false
        case .section:
            return false
        case .synopsis:
            return false
        case .note:
            return true
        case .inlineNote:
            return false
        case .boneyard:
            return true
        case .pageBreak:
            return false
        case .lineBreak:
            return true
        case .emphasis:
            return true
        }
    }
    
    public var canBeInline: Bool {
        switch self {
        case .titlePage:
            return false
        case .sceneHeading:
            return false
        case .sceneNumber:
            return true
        case .dialogue:
            return false
        case .parenthetical:
            return false
        case .action:
            return false
        case .centered:
            return false
        case .transition:
            return false
        case .section:
            return false
        case .synopsis:
            return false
        case .note:
            return false
        case .inlineNote:
            return true
        case .boneyard:
            return false
        case .pageBreak:
            return false
        case .lineBreak:
            return false
        case .emphasis:
            return true
        }
    }
    
    public var allowedChildren: [FountainElementToken]? {
        switch self {
        case .titlePage:
            return [.titlePage(text: "")] + FountainEmphasisStyle.tokens
        case .sceneHeading:
            return [.sceneNumber(text: "")]
        case .sceneNumber:
            return nil
        case .dialogue:
            return [.inlineNote(text: ""), .lineBreak, .parenthetical(text: "")] + FountainEmphasisStyle.tokens
        case .parenthetical:
            return FountainEmphasisStyle.tokens
        case .action:
            return [.centered(text: ""), .inlineNote(text: ""), .lineBreak] + FountainEmphasisStyle.tokens
        case .centered:
            return FountainEmphasisStyle.tokens
        case .transition:
            return nil
        case .section:
            return [
                .synopsis(text: ""),
                .section(text: ""),
                .sceneHeading(text: ""),
                .action(text: ""),
                .centered(text: ""),
                .dialogue(text: ""),
                .transition(text: ""),
                .note(text: ""),
                .pageBreak,
                .boneyard(text: "")
            ]
        case .synopsis:
            return FountainEmphasisStyle.tokens
        case .note:
            return FountainEmphasisStyle.tokens
        case .inlineNote:
            return FountainEmphasisStyle.tokens
        case .boneyard:
            return [
                .synopsis(text: ""),
                .section(text: ""),
                .sceneHeading(text: ""),
                .action(text: ""),
                .centered(text: ""),
                .dialogue(text: ""),
                .transition(text: ""),
                .note(text: ""),
                .pageBreak
            ]
        case .pageBreak:
            return nil
        case .lineBreak:
            return nil
        case .emphasis:
            return nil
        }
    }
    
    public var childTokens: [FountainElementToken]? {
        switch self {
        case .titlePage(_, let children):
            return children
        case .sceneHeading(_, let children):
            return children
        case .sceneNumber:
            return nil
        case .dialogue(_, let children):
            return children
        case .parenthetical(_, let children):
            return children
        case .action(_, let children):
            return children
        case .centered(_, let children):
            return children
        case .transition:
            return nil
        case .section(_, let children):
            return children
        case .synopsis(_, let children):
            return children
        case .note(_, let children):
            return children
        case .inlineNote(_, let children):
            return children
        case .boneyard(_, let children):
            return children
        case .pageBreak:
            return nil
        case .lineBreak:
            return nil
        case .emphasis:
            return nil
        }
    }
    
    public func newInstance(_ text: String) -> FountainElementToken {
        switch self {
        case .titlePage:
            return .titlePage(text: text)
        case .sceneHeading:
            return .sceneHeading(text: text)
        case .sceneNumber:
            return .sceneNumber(text: text)
        case .dialogue:
            return .dialogue(text: text)
        case .parenthetical:
            return .parenthetical(text: text)
        case .action:
            return .action(text: text)
        case .centered:
            return .centered(text: text)
        case .transition:
            return .transition(text: text)
        case .section:
            return .section(text: text)
        case .synopsis:
            return .synopsis(text: text)
        case .note:
            return .note(text: text)
        case .inlineNote:
            return .inlineNote(text: text)
        case .boneyard:
            return .boneyard(text: text)
        case .pageBreak:
            return .pageBreak
        case .lineBreak:
            return .lineBreak
        case .emphasis(_, let style):
            return .emphasis(text: text, style: style)
        }
    }
    
    public static var allCases: [FountainElementToken] {
        var cases: [FountainElementToken] = [
            .titlePage(text: ""),
            .sceneHeading(text: ""),
            .sceneNumber(text: ""),
            .parenthetical(text: ""),
            .dialogue(text: ""),
            .centered(text: ""),
            .transition(text: ""),
            .section(text: ""),
            .synopsis(text: ""),
            .note(text: ""),
            .inlineNote(text: ""),
            .boneyard(text: ""),
            .pageBreak,
            .lineBreak
        ]
        cases.append(contentsOf: FountainEmphasisStyle.tokens)
        cases.append(.action(text: ""))
        return cases
    }
    
}
public enum FountainEmphasisStyle: CaseIterable {
    
    case boldItalicUnderline
    case boldUnderline
    case italicUnderline
    case boldItalic
    case bold
    case italic
    case underline
    
    internal var regex: NSRegularExpression {
        switch self {
        case .boldItalicUnderline:
            return try! NSRegularExpression(pattern: #"(_{1}\*{3}(?=.+\*{3}_{1})|\*{3}_{1}(?=.+_{1}\*{3}))(.+?)(\*{3}_{1}|_{1}\*{3})"#)
        case .boldUnderline:
            return try! NSRegularExpression(pattern: #"(_{1}\*{2}(?=.+\*{2}_{1})|\*{2}_{1}(?=.+_{1}\*{2}))(.+?)(\*{2}_{1}|_{1}\*{2})"#)
        case .italicUnderline:
            return try! NSRegularExpression(pattern: #"(?:_{1}\*{1}(?=.+\*{1}_{1})|\*{1}_{1}(?=.+_{1}\*{1}))(.+?)(\*{1}_{1}|_{1}\*{1})"#)
        case .boldItalic:
            return try! NSRegularExpression(pattern: #"(\*{3}(?=.+\*{3}))(.+?)(\*{3})"#)
        case .bold:
            return try! NSRegularExpression(pattern: #"(\*{2}(?=.+\*{2}))(.+?)(\*{2})"#)
        case .italic:
            return try! NSRegularExpression(pattern: #"(\*{1}(?=.+\*{1}))(.+?)(\*{1})"#)
        case .underline:
            return try! NSRegularExpression(pattern: #"(_{1}(?=.+_{1}))(.+?)(_{1})"#)
        }
    }
    
    static var tokens: [FountainElementToken] {
        self.allCases.map({ FountainElementToken.emphasis(text: "", style: $0) })
    }
    
}
