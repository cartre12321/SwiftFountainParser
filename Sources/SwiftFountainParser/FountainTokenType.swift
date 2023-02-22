//
//  FountainScreenplayElementToken.swift
//  
//
//  Created by Carter Riddall on 2023-02-21.
//

import Foundation



public enum FountainTokenType: CaseIterable {
    
    case titlePage
    
    case sceneHeading
    case sceneNumber
    
    case dialogue
    case parenthetical
    
    case action
    case centered
    
    case transition
    
    case section
    case synopsis
    
    case note
    case inlineNote
    case boneyard
    
    case pageBreak
    case lineBreak
    
    case emphasis(style: FountainEmphasisStyle)
    
    internal var regex: String {
        switch self {
        case .titlePage:
            return #"^(?i)((?:title|credit|author[s]?|source|notes|draft date|date|contact|copyright)\:)"#
        case .sceneHeading:
            return #"^(?i)((?:\*{0,3}_?)?(?:(?:int|ext|est|i\/e)[. ]).+)|^(?:\.(?!\.+))(.+)"#
        case .sceneNumber:
            return #"( *#(.+)# *)"#
        case .dialogue:
            return #"^([A-Z*_]+[0-9A-Z (._\-')]*)(\^?)?(?:\n(?!\n+))([\s\S]+)"#
        case .parenthetical:
            return #"^(\(.+\))$"#
        case .action:
            return #"^(.+)"#
        case .centered:
            return #"^(?:> *)(.+)(?: *<)(\n.+)*"#
        case .transition:
            return #"^((?:FADE (?:TO BLACK|OUT)|CUT TO BLACK)\.|.+ TO\:)|^(?:> *)(.+)"#
        case .section:
            return #"^(#+)(?: *)(.*)"#
        case .synopsis:
            return #"^(?:\=(?!\=+) *)(.*)"#
        case .note:
            return #"^(?:\[{2}(?!\[+))(.+)(?:\]{2}(?!\[+))$"#
        case .inlineNote:
            return #"(?:\[{2}(?!\[+))([\s\S]+?)(?:\]{2}(?!\[+))"#
        case .boneyard:
            return #"(^\/\*|^\*\/)$"#
        case .pageBreak:
            return #"^\={3,}$"#
        case .lineBreak:
            return #"^ {2}$"#
        case let .emphasis(style):
            return style.regex
        }
    }
    
    public static var allCases: [FountainTokenType] {
        var cases: [FountainTokenType] = [
            .titlePage,
            .sceneHeading,
            .sceneNumber,
            .dialogue,
            .parenthetical,
            .action,
            .centered,
            .transition,
            .section,
            .synopsis,
            .note,
            .inlineNote,
            .boneyard,
            .pageBreak,
            .lineBreak
        ]
        for style in FountainEmphasisStyle.allCases {
            cases.append(.emphasis(style: style))
        }
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
    
    internal var regex: String {
        switch self {
        case .boldItalicUnderline:
            return #"(_{1}\*{3}(?=.+\*{3}_{1})|\*{3}_{1}(?=.+_{1}\*{3}))(.+?)(\*{3}_{1}|_{1}\*{3})"#
        case .boldUnderline:
            return #"(_{1}\*{2}(?=.+\*{2}_{1})|\*{2}_{1}(?=.+_{1}\*{2}))(.+?)(\*{2}_{1}|_{1}\*{2})"#
        case .italicUnderline:
            return #"(?:_{1}\*{1}(?=.+\*{1}_{1})|\*{1}_{1}(?=.+_{1}\*{1}))(.+?)(\*{1}_{1}|_{1}\*{1})"#
        case .boldItalic:
            return #"(\*{3}(?=.+\*{3}))(.+?)(\*{3})"#
        case .bold:
            return #"(\*{2}(?=.+\*{2}))(.+?)(\*{2})"#
        case .italic:
            return #"(\*{1}(?=.+\*{1}))(.+?)(\*{1})"#
        case .underline:
            return #"(_{1}(?=.+_{1}))(.+?)(_{1})"#
        }
    }
    
}
