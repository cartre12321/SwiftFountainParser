//
//  FountainTransition.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainTransition: FountainBlockElement {
    
    override var type: FountainElementToken {
        .transition(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content, allowsChildren: false)
    }
}
