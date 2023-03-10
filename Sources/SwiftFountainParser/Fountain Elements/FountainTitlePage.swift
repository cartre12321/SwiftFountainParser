//
//  FountainTitlePage.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainTitlePage: FountainLineElement {
    
    override var token: FountainElementToken {
        .titlePage(text: self.content)
    }
    
    init(content: String) {
        super.init(content: content)
    }
}
