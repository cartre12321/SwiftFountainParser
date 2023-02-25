//
//  FountainSceneNumber.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainSceneNumber: FountainInlineElement {
    
    override var token: FountainElementToken {
        .sceneNumber(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
