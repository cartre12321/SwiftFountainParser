//
//  FounainLineElement.swift
//  
//
//  Created by Carter Riddall on 2023-02-23.
//

import Foundation

public class FountainLineElement: FountainElement {
    
    public static var allCases: [FountainElementToken] {
        FountainElementToken.allCases.filter { $0.canBeLine }
    }
    
}
