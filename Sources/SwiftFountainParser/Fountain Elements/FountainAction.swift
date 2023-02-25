//
//  FountainAction.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainAction: FountainBlockElement {
    
    init(content: String, parent: FountainElementToken? = nil, childElements: [FountainElement]? = nil) {
        super.init(content: content, parentToken: parent, childElements: childElements)
    }
}
