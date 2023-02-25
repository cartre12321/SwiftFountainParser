//
//  FountainNote.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainNote: FountainLineElement, FountainDelimiter {
    
    var openSymbol: String { "[[" }
    var closeSymbol: String { "]]" }
    
    override var token: FountainElementToken {
        .note(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
