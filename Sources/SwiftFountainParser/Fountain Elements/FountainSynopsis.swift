//
//  FountainSynopsis.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainSynopsis: FountainBlockElement {
    
    override var token: FountainElementToken {
        .synopsis(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
