//
//  FountainCentered.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainCentered: FountainLineElement {
    override var type: FountainElementToken {
        .centered(text: self.content)
    }
    init(content: String) {
        super.init(content: content, allowsChildren: true)
    }
}
