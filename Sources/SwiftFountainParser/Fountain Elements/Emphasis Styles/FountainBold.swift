//
//  FountainBold.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainBold: FountainEmphasis, FountainDelimiter {
    var openSymbol: String = "**"
    
    var closeSymbol: String = "**"
    
    init(content: String) {
        super.init(content: content, style: .bold)
    }
}
