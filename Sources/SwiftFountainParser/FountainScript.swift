//
//  File.swift
//  
//
//  Created by Carter Riddall on 2023-02-23.
//

import Foundation

open class FountainScript {
    var elements: [FountainElement]
    var sceneCount: Int { self.elements.filter({ $0.type == .sceneHeading(text: $0.content) }).count }
    
    init(elements: [FountainElement]) {
        self.elements = elements
    }
    
    
}
