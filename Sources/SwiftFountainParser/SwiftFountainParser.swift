import Foundation
import Algorithms

/// Primary parser class to generate FountainScript from a string
public struct SwiftFountainParser {
    public init() {
    }
    
    func parseBlock(_ block: String) -> FountainElement? {
        for elementType in FountainBlockElement.allCases {
            if elementType.regex.firstMatch(in: block, range: NSRange(location: 0, length: block.utf16.count)) != nil {
                switch elementType {
                case .titlePage:
                    let element = FountainElementToken.titlePage(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .sceneHeading:
                    let element = FountainElementToken.sceneHeading(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .dialogue:
                    let element = FountainElementToken.dialogue(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .action:
                    let element = FountainElementToken.action(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .centered:
                    let element = FountainElementToken.centered(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .transition:
                    let element = FountainElementToken.transition(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .section:
                    let element = FountainElementToken.section(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .synopsis:
                    let element = FountainElementToken.synopsis(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .note:
                    let element = FountainElementToken.note(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .boneyard:
                    let element = FountainElementToken.boneyard(text: block).generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                case .pageBreak:
                    let element = FountainElementToken.pageBreak.generateElement()
                    if element.allowsChildren {
                        element.childElements = parseLines(element.lines)
                    }
                    return element
                default:
                    return nil
                }
            }
        }
        return FountainAction(content: block)
    }
    func parseLines(_ lines: [String]) -> [FountainElement]? {
        var elements: [FountainElement] = []
        
        for line in lines {
            for elementType in FountainLineElement.allCases {
                if elementType.regex.firstMatch(in: line, range: NSRange(location: 0, length: line.utf16.count)) != nil {
                    switch elementType {
                    case .titlePage:
                        let element = FountainElementToken.titlePage(text: line).generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    case .parenthetical:
                        let element = FountainElementToken.parenthetical(text: line).generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    case .centered:
                        let element = FountainElementToken.centered(text: line).generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    case .note:
                        let element = FountainElementToken.note(text: line).generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    case .boneyard:
                        let element = FountainElementToken.boneyard(text: line).generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    case .lineBreak:
                        let element = FountainElementToken.lineBreak.generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    case .emphasis(_, let style):
                        let element = FountainElementToken.emphasis(text: line, style: style).generateElement()
                        if element.allowsChildren {
                            element.childElements = parseInline(element.content)
                        }
                        elements.append(element)
                    default:
                        print("Couldn't generate element somehow")
                        continue
                    }
                }
            }
        }
        
        if !elements.isEmpty {
            return elements
        } else {
            return nil
        }
    }
    func parseInline(_ line: String) -> [FountainElement]? {
        var elements: [FountainElement] = []
        
        for subString in line.components(separatedBy: "")
            .combinations(ofCount: 1...line.count)
            .map({ $0.joined() }) {
            
            for elementType in FountainInlineElement.allCases {
                let range = elementType.regex.rangeOfFirstMatch(in: subString, range: NSRange(location: 0, length: subString.utf16.count))
                if range != NSRange(location: NSNotFound, length: 0) {
                    switch elementType {
                    case .sceneNumber:
                        elements.append(FountainElementToken.sceneNumber(text: (subString as NSString).substring(with: range)).generateElement())
                    case .inlineNote:
                        elements.append(FountainElementToken.inlineNote(text: (subString as NSString).substring(with: range)).generateElement())
                    case .emphasis(_, let style):
                        elements.append(FountainElementToken.emphasis(text: (subString as NSString).substring(with: range), style: style).generateElement())
                    default:
                        print("Couldn't generate element somehow")
                        continue
                    }
                }
            }
            
        }
        
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
        let mutableScript = NSMutableString(string: script)
        FountainRegexes.standardizer.replaceMatches(in: mutableScript, options: [.reportCompletion], range: NSRange(location: 0, length: mutableScript.length), withTemplate: "\n")
        FountainRegexes.cleaner.replaceMatches(in: mutableScript, range: NSRange(location: 0, length: mutableScript.length), withTemplate: "")
        FountainRegexes.whitespacer.replaceMatches(in: mutableScript, options: [.reportCompletion], range: NSRange(location: 0, length: mutableScript.length), withTemplate: "")
        
        var scriptSplit = String(mutableScript).components(separatedBy: "\n\n")
        
        var elements: [FountainElement] = []
        
        while scriptSplit.count != 0 {
            if let element = parseBlock(scriptSplit[0]) {
                elements.append(element)
            }
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
