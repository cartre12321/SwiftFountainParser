//
//  FountainSection.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainSection: FountainBlockElement {
    
    override var type: FountainElementToken {
        .section(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content, allowsChildren: false)
    }
}
