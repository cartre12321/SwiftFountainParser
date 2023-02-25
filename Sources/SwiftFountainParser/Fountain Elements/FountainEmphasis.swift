//
//  FountainEmphasis.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainEmphasis: FountainInlineElement {
    
    override var token: FountainElementToken {
        .emphasis(text: self.content, style: self.style)
    }
    
    var style: FountainEmphasisStyle
    
    init(content: String, style: FountainEmphasisStyle) {
        self.style = style
        super.init(content: content)
    }
}
