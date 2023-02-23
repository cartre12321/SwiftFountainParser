//
//  FountainNote.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainNote: FountainLineElement {
    
    override var type: FountainElementToken {
        .note(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content, allowsChildren: false)
    }
}
