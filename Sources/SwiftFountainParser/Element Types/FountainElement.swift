//
//  FountainElement.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainElement {
    
    private var regex: NSRegularExpression {
        self.token.regex
    }
    
    var token: FountainElementToken {
        .action(text: self.content)
    }
    let parentToken: FountainElementToken?
    var lines: [String] {
        content.components(separatedBy: "\n")
    }
    var allowedChildren: [FountainElementToken]? {
        self.token.allowedChildren
    }
    var childElements: [FountainElement]?
    
    var content: String
    
    init(content: String, parentToken: FountainElementToken? = nil, childElements: [FountainElement]? = nil) {
        self.content = content
        self.parentToken = parentToken
        self.childElements = childElements
    }
    
}
