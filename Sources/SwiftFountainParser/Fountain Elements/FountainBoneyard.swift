//
//  FountainBoneyard.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainBoneyard: FountainBlockElement, FountainDelimiter {
    
    var openSymbol: String = "/*"
    
    var closeSymbol: String = "*/"
    
    
    override var type: FountainElementToken {
        .boneyard(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content, allowsChildren: true)
    }
}
