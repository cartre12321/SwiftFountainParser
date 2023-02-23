//
//  Errors.swift
//  
//
//  Created by Carter Riddall on 2023-02-23.
//

import Foundation

enum ParsingError: Error, CustomStringConvertible {
    case couldNotOpenFile
    
    var description: String {
        switch self {
        case .couldNotOpenFile:
            return "Unable to open the given file"
        }
    }
}
