//
//  FountainBlockElement.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainBlockElement: FountainElement {
    
    public static var allCases: [FountainElementToken] {
        FountainElementToken.allCases.filter { $0.canBeBlock }
    }
    
}
