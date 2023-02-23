import Foundation
import RegexBuilder

/// Primary parser class to generate FountainScript from a string
public struct SwiftFountainParser {
    public init() {
    }
    
    func parseChunk(_ chunk: String) -> FountainElement {
        for elementType in FountainElementToken.allCases {
            guard let regex = try? NSRegularExpression(pattern: elementType.regex) else {
                print("Couldn't use regular expression for:\n\(elementType)")
                continue
            }
            if regex.firstMatch(in: chunk, range: NSRange(location: 0, length: chunk.utf16.count)) != nil {
                switch elementType {
                case .titlePage:
                    return FountainElementToken.titlePage(text: chunk).generateElement()
                case .sceneHeading:
                    return FountainElementToken.sceneHeading(text: chunk).generateElement()
                case .sceneNumber:
                    return FountainElementToken.sceneNumber(text: chunk).generateElement()
                case .dialogue:
                    return FountainElementToken.dialogue(text: chunk).generateElement()
                case .parenthetical:
                    return FountainElementToken.parenthetical(text: chunk).generateElement()
                case .action:
                    return FountainElementToken.action(text: chunk).generateElement()
                case .centered:
                    return FountainElementToken.centered(text: chunk).generateElement()
                case .transition:
                    return FountainElementToken.transition(text: chunk).generateElement()
                case .section:
                    return FountainElementToken.section(text: chunk).generateElement()
                case .synopsis:
                    return FountainElementToken.synopsis(text: chunk).generateElement()
                case .note:
                    return FountainElementToken.note(text: chunk).generateElement()
                case .inlineNote:
                    return FountainElementToken.inlineNote(text: chunk).generateElement()
                case .boneyard:
                    return FountainElementToken.boneyard(text: chunk).generateElement()
                case .pageBreak:
                    return FountainElementToken.pageBreak.generateElement()
                case .lineBreak:
                    return FountainElementToken.lineBreak.generateElement()
                case .emphasis( _, let style):
                    return FountainElementToken.emphasis(text: chunk, style: style).generateElement()
                }
            }
        }
        return FountainAction(content: chunk)
    }
    func parseLines(_ block: String) -> [FountainElement]? {
        var elements: [FountainElement] = []
        
        
        if !elements.isEmpty {
            return elements
        } else {
            return nil
        }
    }
    func parseInline(_ block: String) -> [FountainElement]? {
        var elements: [FountainElement] = []
        
        
        if !elements.isEmpty {
            return elements
        } else {
            return nil
        }
    }
    
    /// Parses string representation of a script into a FountainScript object
    /// - Parameter script: String version of script to be parsed
    /// - Returns: FountainScript object representing the input script
    public func parseScript(_ script: String) -> FountainScript {
        var scriptSplit = script.components(separatedBy: "\n\n")
        
        var elements: [FountainElement] = []
        
        while scriptSplit.count != 0 {
            elements.append(parseChunk(scriptSplit[0]))
            scriptSplit.remove(at: 0)
        }
        return FountainScript(elements: elements)
    }
    
    public func parseScript(from path: String) throws -> FountainScript {
        if let url = URL(string: path) {
            return try parseScript(fromURL: url)
        } else {
            throw(ParsingError.couldNotOpenFile)
        }
    }
    
    public func parseScript(fromURL path: URL) throws -> FountainScript {
        return parseScript(try String(contentsOf: path))
    }
}
