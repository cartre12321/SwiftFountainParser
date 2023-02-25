//
//  FountainDialogue.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainDialogue: FountainBlockElement {
    
    override var token: FountainElementToken {
        .dialogue(text: self.content)
    }
    
    var isDual: Bool
    
    var character: String {
        self.lines[0]
    }
    var line: String { self.lines[1...].joined(separator: "\n") }
    
    init(content: String, isDual: Bool = false) {
        self.isDual = isDual
        super.init(content: content)
    }
}
