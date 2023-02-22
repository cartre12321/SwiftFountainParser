//
//  FountainPageBreak.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainPageBreak: FountainElement {
    init(content: String) {
        super.init(content: content, allowsChildren: false, regex: FountainTokenType.pageBreak.regex)
    }
}
