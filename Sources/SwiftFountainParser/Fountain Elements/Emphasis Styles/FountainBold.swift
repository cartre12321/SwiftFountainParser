//
//  FountainBold.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainBold: FountainEmphasis {
    init(content: String) {
        super.init(content: content, style: .bold)
    }
}
