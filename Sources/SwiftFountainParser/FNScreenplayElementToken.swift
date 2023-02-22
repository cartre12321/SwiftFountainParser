//
//  ScreenplayElementToken.swift
//  
//
//  Created by Carter Riddall on 2023-02-21.
//

import Foundation

enum FNScreenplayElement: String, CaseIterable {
    
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

public class FNScreenplayElementToken {
    
    let type: FNScreenplayElement
    var content: String
    
    init(type: FNScreenplayElement, content: String) {
        self.type = type
        self.content = content
    }
    
}

public class FNTitlePage: FNScreenplayElementToken {
    
    private static var regex = #"^(?i)((?:title|credit|author[s]?|source|notes|draft date|date|contact|copyright)\:)"#
    
    var field: String
    
    init(_ content: String) {
        
        self.field = content.components(separatedBy: ":")[0]
        
        super.init(type: .titlePage, content: content)
        
    }
}

public class FNSceneHeading: FNScreenplayElementToken {
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
    
    init(_ content: String) {
        let typeSplit = content.components(separatedBy: ". ")
        let timeSplit = typeSplit.last!.components(separatedBy: " - ")
        self.locationType = LocationType(rawValue: typeSplit[0])
        self.location = timeSplit[0]
        self.time = FNSceneTime(rawValue: timeSplit.last!)
        super.init(type: .sceneHeading, content: content)
    }
    
}

public class FNSceneNumber: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .sceneNumber, content: content)
    }
}

public class FNTransition: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .transition, content: content)
    }
    
}


public class FNDialogue: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .dialogue, content: content)
    }
    
}

public class FNParenthetical: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .parenthetical, content: content)
    }
    
}

public class FNAction: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .action, content: content)
    }
    
}

public class FNCentered: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .centered, content: content)
    }
    
}

public class FNSection: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .section, content: content)
    }
    
}

public class FNSynopsis: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .synopsis, content: content)
    }
    
}

public class FNNote: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .note, content: content)
    }
    
}

public class FNNoteInline: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .noteInline, content: content)
    }
    
}

public class FNBoneyard: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .boneyard, content: content)
    }
    
}

public class FNPageBreak: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .pageBreak, content: content)
    }
    
}

public class FNLineBreak: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .lineBreak, content: content)
    }
    
}

public class FNEmphasis: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .emphasis, content: content)
    }
    
}

public class FNBoldItalicUnderline: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .boldItalicUnderline, content: content)
    }
    
}

public class FNBoldUnderline: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .boldUnderline, content: content)
    }
    
}

public class FNItalicUnderline: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .italicUnderline, content: content)
    }
    
}

public class FNBoldItalic: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .boldItalic, content: content)
    }
    
}

public class FNBold: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .bold, content: content)
    }
    
}

public class FNItalic: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .italic, content: content)
    }
    
}

public class FNUnderline: FNScreenplayElementToken {
    
    init(_ content: String) {
        super.init(type: .underline, content: content)
    }
    
}
