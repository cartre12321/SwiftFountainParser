//
//  FountainTransition.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainTransition: FountainBlockElement {
    
    override var token: FountainElementToken {
        .transition(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
