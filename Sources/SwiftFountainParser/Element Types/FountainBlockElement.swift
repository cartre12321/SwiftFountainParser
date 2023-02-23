//
//  FountainBlockElement.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainBlockElement: FountainElement {
    
    public static var allCases: [FountainElementToken] {
        FountainElementToken.allCases
    }
    
    override init(content: String, allowsChildren: Bool) {
        super.init(content: content, allowsChildren: allowsChildren)
        self.childElements = SwiftFountainParser().parseLines(content)
    }
}
