//
//  FountainInlineNote.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainInlineNote: FountainInlineElement, FountainDelimiter {
    
    var openSymbol: String { "[[" }
    var closeSymbol: String { "]]" }
    
    override var token: FountainElementToken {
        .inlineNote(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
