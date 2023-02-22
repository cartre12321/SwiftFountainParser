//
//  FountainRegex.swift
//  
//
//  Created by Carter Riddall on 2023-02-22.
//

import Foundation

struct FountainParser {
    func parseScript(_ script: String) {
        
    }
    
    func firstMatch(text: String, regex: String) -> String? {
        let expression = try! NSRegularExpression(pattern: regex)
        for line in SwiftFountainParser().splitScreenplay(text) {
            let range = expression.rangeOfFirstMatch(in: line, range: NSMakeRange(0, line.utf16.count))
            if range.location != NSNotFound {
                return (line as NSString).substring(with: range)
            }
        }
        return nil
    }
}
