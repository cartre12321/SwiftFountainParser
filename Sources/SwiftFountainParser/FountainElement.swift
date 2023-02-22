//
//  FountainElement.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainElement {
    
    private let regex: String
    
    var lines: [String]
    let allowsChildren: Bool
    var childElements: [FountainElement]?
    
    var content: String
    
    init(content: String, allowsChildren: Bool, regex: String) {
        self.content = content
        self.lines = content.components(separatedBy: "\n")
        self.allowsChildren = allowsChildren
        self.regex = regex
    }
}
