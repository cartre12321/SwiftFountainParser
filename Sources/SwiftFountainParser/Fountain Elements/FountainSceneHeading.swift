//
//  FountainSceneHeading.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainSceneHeading: FountainBlockElement {
    
    override var token: FountainElementToken {
        .sceneHeading(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
