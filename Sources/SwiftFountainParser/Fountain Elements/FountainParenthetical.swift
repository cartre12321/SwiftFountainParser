//
//  FountainParenthetical.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainParenthetical: FountainLineElement {
    
    override var type: FountainElementToken {
        .parenthetical(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content, allowsChildren: false)
    }
}
