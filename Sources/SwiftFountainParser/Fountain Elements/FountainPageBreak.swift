//
//  FountainPageBreak.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainPageBreak: FountainBlockElement {
    
    override var type: FountainElementToken {
        .pageBreak
    }
    
    init() {
        super.init(content: "===", allowsChildren: false)
    }
}
