import Foundation
import RegexBuilder

public struct SwiftFountainParser {
    public init() {
    }
    
    internal func splitScreenplay(_ script: String) -> [String] {
        script.components(separatedBy: "\n\n")
    }
}
