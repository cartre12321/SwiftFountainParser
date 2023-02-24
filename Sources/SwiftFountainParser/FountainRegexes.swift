//
//  File.swift
//  
//
//  Created by Carter Riddall on 2023-02-24.
//

import Foundation

struct FountainRegexes {
    static let cleaner = try! NSRegularExpression(pattern: #"^\n+|\n+$"#)
    static let standardizer = try! NSRegularExpression(pattern: #"\r\n|\r"#)
    static let whitespacer = try! NSRegularExpression(pattern: #"(?m)^\t+|^ {3,}"#)
}
