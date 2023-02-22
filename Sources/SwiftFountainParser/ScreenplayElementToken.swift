//
//  ScreenplayElementToken.swift
//  
//
//  Created by Carter Riddall on 2023-02-21.
//

import Foundation

enum ScreenplayElement: String, CaseIterable {
    
    case titlePage = #"^(?i)((?:title|credit|author[s]?|source|notes|draft date|date|contact|copyright)\:)"#
    
    case sceneHeading = #"^(?i)((?:\*{0,3}_?)?(?:(?:int|ext|est|i\/e)[. ]).+)|^(?:\.(?!\.+))(.+)"#
    case sceneNumber = #"( *#(.+)# *)"#
    
    case transition = #"^((?:FADE (?:TO BLACK|OUT)|CUT TO BLACK)\.|.+ TO\:)|^(?:> *)(.+)"#
    
    case dialogue = #"^([A-Z*_]+[0-9A-Z (._\-')]*)(\^?)?(?:\n(?!\n+))([\s\S]+)"#
    case parenthetical = #"^(\(.+\))$"#
    
    case action = #"^(.+)"#
    case centered = #"^(?:> *)(.+)(?: *<)(\n.+)*"#
    
    case section = #"^(#+)(?: *)(.*)"#
    case synopsis = #"^(?:\=(?!\=+) *)(.*)"#
    
    case note = #"^(?:\[{2}(?!\[+))(.+)(?:\]{2}(?!\[+))$"#
    case noteInline = #"(?:\[{2}(?!\[+))([\s\S]+?)(?:\]{2}(?!\[+))"#
    case boneyard = #"(^\/\*|^\*\/)$"#
    
    case pageBreak = #"^\={3,}$"#
    case lineBreak = #"^ {2}$"#
    
    case emphasis = #"(_|\*{1,3}|_\*{1,3}|\*{1,3}_)(.+)(_|\*{1,3}|_\*{1,3}|\*{1,3}_)"#
    case boldItalicUnderline = #"(_{1}\*{3}(?=.+\*{3}_{1})|\*{3}_{1}(?=.+_{1}\*{3}))(.+?)(\*{3}_{1}|_{1}\*{3})"#
    case boldUnderline = #"(_{1}\*{2}(?=.+\*{2}_{1})|\*{2}_{1}(?=.+_{1}\*{2}))(.+?)(\*{2}_{1}|_{1}\*{2})"#
    case italicUnderline = #"(?:_{1}\*{1}(?=.+\*{1}_{1})|\*{1}_{1}(?=.+_{1}\*{1}))(.+?)(\*{1}_{1}|_{1}\*{1})"#
    case boldItalic = #"(\*{3}(?=.+\*{3}))(.+?)(\*{3})"#
    case bold = #"(\*{2}(?=.+\*{2}))(.+?)(\*{2})"#
    case italic = #"(\*{1}(?=.+\*{1}))(.+?)(\*{1})"#
    case underline = #"(_{1}(?=.+_{1}))(.+?)(_{1})"#
    
}

enum blah {
    case thing(FNTitlePage)
}

public class ScreenplayElementToken {
    
    let type: ScreenplayElement
    var content: String
    
    init(type: ScreenplayElement, content: String) {
        self.type = type
        self.content = content
    }
    
}

public class FNTitlePage: ScreenplayElementToken {
    
    private static var regex = #"^(?i)((?:title|credit|author[s]?|source|notes|draft date|date|contact|copyright)\:)"#
    
    var field: String
    
    override init(type: ScreenplayElement, content: String) {
        
        self.field = content.components(separatedBy: ":")[0]
        
        super.init(type: type, content: content)
        
    }
}

public class FNSceneHeading: ScreenplayElementToken {
    enum LocationType: String {
        case INT
        case EXT
        case INT_EXT = "INT./EXT."
    }
    enum FNSceneTime: String {
        case DAY
        case NIGHT
        case MORNING
        case AFTERNOON
        case EVENING
        case DAWN
        case DUSK
        case NOON
    }
    var locationType: LocationType?
    var location: String
    var time: FNSceneTime?
    
    override init(type: ScreenplayElement, content: String) {
        var typeSplit = content.components(separatedBy: ". ")
        let timeSplit = typeSplit.last!.components(separatedBy: " - ")
        self.locationType = LocationType(rawValue: typeSplit[0])
        self.location = timeSplit[0]
        self.time = FNSceneTime(rawValue: timeSplit.last!)
        super.init(type: type, content: content)
    }
    
}
