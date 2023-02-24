//
//  FountainScreenplayElementToken.swift
//  
//
//  Created by Carter Riddall on 2023-02-21.
//

import Foundation



public enum FountainElementToken: Equatable, CaseIterable {
    
    case titlePage(text: String)
    
    case sceneHeading(text: String)
    case sceneNumber(text: String)
    
    case dialogue(text: String)
    case parenthetical(text: String)
    
    case action(text: String)
    case centered(text: String)
    
    case transition(text: String)
    
    case section(text: String)
    case synopsis(text: String)
    
    case note(text: String)
    case inlineNote(text: String)
    case boneyard(text: String)
    
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
        case .titlePage(text: let text):
            return FountainTitlePage(content: text)
        case .sceneHeading(text: let text):
            return FountainSceneHeading(content: text)
        case .sceneNumber(text: let text):
            return FountainSceneNumber(content: text)
        case .dialogue(text: let text):
            return FountainDialogue(content: text)
        case .parenthetical(text: let text):
            return FountainParenthetical(content: text)
        case .action(text: let text):
            return FountainAction(content: text)
        case .centered(text: let text):
            return FountainCentered(content: text)
        case .transition(text: let text):
            return FountainTransition(content: text)
        case .section(text: let text):
            return FountainSection(content: text)
        case .synopsis(text: let text):
            return FountainSynopsis(content: text)
        case .note(text: let text):
            return FountainNote(content: text)
        case .inlineNote(text: let text):
            return FountainInlineNote(content: text)
        case .boneyard(text: let text):
            return FountainBoneyard(content: text)
        case .pageBreak:
            return FountainPageBreak()
        case .lineBreak:
            return FountainLineBreak()
        case .emphasis(text: let text, style: let style):
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
        for style in FountainEmphasisStyle.allCases {
            cases.append(.emphasis(text: "", style: style))
        }
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
    
}
