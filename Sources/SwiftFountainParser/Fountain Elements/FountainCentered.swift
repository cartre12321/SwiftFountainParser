//
//  FountainCentered.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainCentered: FountainElement {
    init(content: String) {
        super.init(content: content, allowsChildren: true, regex: FountainTokenType.centered.regex)
    }
}
