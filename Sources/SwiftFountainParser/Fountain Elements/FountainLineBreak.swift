//
//  FountainLineBreak.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainLineBreak: FountainLineElement {
    
    override var token: FountainElementToken {
        .lineBreak
    }
    
    init() {
        super.init(content: "  ")
    }
}
