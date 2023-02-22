//
//  FountainSceneNumber.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

public class FountainSceneNumber: FountainElement {
    init(content: String) {
        super.init(content: content, allowsChildren: false, regex: FountainTokenType.sceneNumber.regex)
    }
}
