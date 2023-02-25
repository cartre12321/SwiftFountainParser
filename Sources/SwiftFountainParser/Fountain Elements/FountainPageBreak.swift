//
//  FountainPageBreak.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainPageBreak: FountainBlockElement {
    
    override var token: FountainElementToken {
        .pageBreak
    }
    
    init() {
        super.init(content: "===")
    }
}
