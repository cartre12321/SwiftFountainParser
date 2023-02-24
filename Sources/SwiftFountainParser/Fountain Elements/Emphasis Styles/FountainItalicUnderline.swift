//
//  FountainItalicUnderline.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainItalicUnderline: FountainEmphasis, FountainDelimiter {
    var openSymbol: String = "_*"
    
    var closeSymbol: String = "*_"
    
    init(content: String) {
        super.init(content: content, style: .italicUnderline)
    }
}
