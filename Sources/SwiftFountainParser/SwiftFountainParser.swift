import Foundation
import Algorithms

/// Primary parser class to generate FountainScript from a string
public struct SwiftFountainParser {
    public init() {
    }
    
    func lexBlock(_ block: String) -> FountainElementToken? {
        for elementType in FountainBlockElement.allCases {
            if elementType.regex.firstMatch(in: block, range: NSRange(location: 0, length: block.utf16.count)) != nil {
                switch elementType {
                case .titlePage:
                    return FountainElementToken.titlePage(text: block)
                case .sceneHeading:
                    return FountainElementToken.sceneHeading(text: block)
                case .dialogue:
                    return FountainElementToken.dialogue(text: block)
                case .action:
                    return FountainElementToken.action(text: block)
                case .centered:
                    return FountainElementToken.centered(text: block)
                case .transition:
                    return FountainElementToken.transition(text: block)
                case .section:
                    return FountainElementToken.section(text: block)
                case .synopsis:
                    return FountainElementToken.synopsis(text: block)
                case .note:
                    return FountainElementToken.note(text: block)
                case .boneyard:
                    return FountainElementToken.boneyard(text: block)
                case .pageBreak:
                    return FountainElementToken.pageBreak
                default:
                    return nil
                }
            }
        }
        return FountainElementToken.action(text: block)
    }
    func parseLines(_ lines: [FountainElementToken]) -> [FountainElementToken] {
        var parsedLines: [FountainElementToken] = []
        for line in lines {
            guard let allowedChildren = line.allowedChildren else { continue }
            var parsedLine: FountainElementToken = .action(text: line.content)
                for elementType in allowedChildren {
                    if elementType.regex.firstMatch(in: line.content, range: NSRange(location: 0, length: line.content.utf16.count)) != nil {
                        switch elementType {
                        case .titlePage:
                            parsedLine = .titlePage(text: line.content)
                        case .sceneHeading:
                            parsedLine = .sceneHeading(text: line.content)
                        case .sceneNumber:
                            parsedLine = .sceneNumber(text: line.content)
                        case .dialogue:
                            parsedLine = .dialogue(text: line.content)
                        case .parenthetical:
                            parsedLine = .parenthetical(text: line.content)
                        case .action:
                            break
                        case .centered:
                            parsedLine = .centered(text: line.content)
                        case .transition:
                            parsedLine = .transition(text: line.content)
                        case .section:
                            parsedLine = .section(text: line.content)
                        case .synopsis:
                            parsedLine = .synopsis(text: line.content)
                        case .note:
                            parsedLine = .note(text: line.content)
                        case .inlineNote:
                            parsedLine = .inlineNote(text: line.content)
                        case .boneyard:
                            parsedLine = .boneyard(text: line.content)
                        case .pageBreak:
                            parsedLine = .pageBreak
                        case .lineBreak:
                            parsedLine = .lineBreak
                        case .emphasis(_, let style):
                            parsedLine = .emphasis(text: line.content, style: style)
                        }
                    }
                }
            parsedLines.append(contentsOf: parseInline(parsedLine))
        }
        guard parsedLines != [] else { return lines }
        return parsedLines
    }
    func parseInline(_ line: FountainElementToken) -> [FountainElementToken] {
        guard let allowedChildren = line.allowedChildren else { return [line] }
        var parsedTokens: [FountainElementToken] = []
        for substring in line.content.allSubstrings().map({ String($0) }) {
            for elementType in allowedChildren {
                if elementType.regex.firstMatch(in: substring, range: NSRange(location: 0, length: substring.utf16.count)) != nil {
                    switch elementType {
                    case .titlePage:
                        parsedTokens.append(.titlePage(text: substring))
                    case .sceneHeading:
                        parsedTokens.append(.sceneHeading(text: substring))
                    case .sceneNumber:
                        parsedTokens.append(.sceneNumber(text: substring))
                    case .dialogue:
                        parsedTokens.append(.dialogue(text: substring))
                    case .parenthetical:
                        parsedTokens.append(.parenthetical(text: substring))
                    case .action:
                        parsedTokens.append(.action(text: substring))
                    case .centered:
                        parsedTokens.append(.centered(text: substring))
                    case .transition:
                        parsedTokens.append(.transition(text: substring))
                    case .section:
                        parsedTokens.append(.section(text: substring))
                    case .synopsis:
                        parsedTokens.append(.synopsis(text: substring))
                    case .note:
                        parsedTokens.append(.note(text: substring))
                    case .inlineNote:
                        parsedTokens.append(.inlineNote(text: substring))
                    case .boneyard:
                        parsedTokens.append(.boneyard(text: substring))
                    case .pageBreak:
                        parsedTokens.append(.pageBreak)
                    case .lineBreak:
                        parsedTokens.append(.lineBreak)
                    case .emphasis(_, let style):
                        parsedTokens.append(.emphasis(text: substring, style: style))
                    }
                }
            }
        }
        guard parsedTokens != [] else { return [line] }
        return parsedTokens
    }
    
    func parseTokens(_ tokens: [FountainElementToken]) -> [FountainElement] {
        let tokens = parseLines(tokens)
        return tokens.map { $0.generateElement() }
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
        
        var elements: [FountainElementToken] = []
        
        while scriptSplit.count != 0 {
            if let element = lexBlock(scriptSplit[0]) {
                elements.append(element)
            }
            scriptSplit.remove(at: 0)
        }
        return FountainScript(elements: parseTokens(elements))
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

extension String {
    func allSubstrings() -> [String] {
        guard self.count != 0 else {
            return []
        }
        var substrings: [String] = []
        for i in 0...self.count - 1 {
            for j in (i + 1)...self.count {
                substrings.append(String(self[index(startIndex, offsetBy: i)..<index(startIndex, offsetBy: j)]))
            }
        }
        return substrings
    }
}
