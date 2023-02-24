//
//  FountainElement.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainElement {
    
    private var regex: NSRegularExpression {
        self.type.regex
    }
    
    var type: FountainElementToken {
        .action(text: self.content)
    }
    var lines: [String] {
        content.components(separatedBy: "\n")
    }
    let allowsChildren: Bool
    var childElements: [FountainElement]?
    
    var content: String
    
    init(content: String, allowsChildren: Bool) {
        self.content = content
        self.allowsChildren = allowsChildren
    }
    
}
