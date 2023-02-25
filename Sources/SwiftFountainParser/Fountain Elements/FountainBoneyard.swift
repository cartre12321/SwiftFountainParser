//
//  FountainBoneyard.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainBoneyard: FountainBlockElement, FountainDelimiter {
    
    var openSymbol: String { "/*" }
    var closeSymbol: String { "*/" }
    
    
    override var token: FountainElementToken {
        .boneyard(text: self.content)
    }
    
    init(content: String, parent: FountainElementToken? = nil, childElements: [FountainElement]? = nil) {
        super.init(content: content)
    }
}
