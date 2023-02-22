//
//  FountainParenthetical.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainParenthetical: FountainElement {
    init(content: String) {
        super.init(content: content, allowsChildren: false, regex: FountainTokenType.parenthetical.regex)
    }
}
