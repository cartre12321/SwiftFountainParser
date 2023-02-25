//
//  File.swift
//  
//
//  Created by Carter Riddall on 2023-02-23.
//

import Foundation
import Html

open class FountainScript {
    var elements: [FountainElement]
    var sceneCount: Int { self.elements.filter({ $0.token == .sceneHeading(text: $0.content) }).count }
    
    init(elements: [FountainElement]) {
        self.elements = elements
    }
    
    fileprivate func childNodesFromElement(_ element: FountainElement) -> [Node]? {
        guard let childElements = element.childElements else {
            return nil
        }
        var children: [Node] = []
        for child in childElements {
            children.append(elementToHtml(child))
        }
        return children
    }
    
    func elementToHtml(_ element: FountainElement) -> Node {
        switch element.token {
        case .titlePage:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("title-page")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .sceneHeading:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("scene-heading")], [
                .fragment([
                    .text(element.content.uppercased())
                ] + (childNodesFromElement(element) ?? []))])
        case .sceneNumber:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("scene-number")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .dialogue:
            return Node.fragment([
                .element("p", attributes: [Attribute<Tag.P>.class("character")], [
                    .text((element as! FountainDialogue).character.uppercased())
                ]),
                .element("p", attributes: [Attribute<Tag.P>.class("dialogue")], [
                    .text((element as! FountainDialogue).line)
                ])
            ])
        case .parenthetical:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("parenthetical")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .action:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("action")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .centered:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("centered")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .transition:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("transition")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .section:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("section")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .synopsis:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("synopsis")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .note:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("note")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .inlineNote:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("inline-note")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .boneyard:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("boneyard")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .pageBreak:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("page-break")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .lineBreak:
            return Node.element("p", attributes: [Attribute<Tag.P>.class("line-break")], [
                .fragment([
                    .text(element.content)
                ] + (childNodesFromElement(element) ?? []))])
        case .emphasis(_, let style):
            switch style {
            case .boldItalicUnderline:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("bold-italic-underline")], [
                    .b([
                        .i([
                            .u([
                                .fragment([
                                    .text(element.content)
                                ] + (childNodesFromElement(element) ?? []))
                            ])
                        ])
                    ])
                ]))
            case .boldUnderline:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("bold-underline")], [
                    .b([
                        .u([
                            .fragment([
                                .text(element.content)
                            ] + (childNodesFromElement(element) ?? []))
                        ])
                    ])
                ]))
            case .italicUnderline:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("italic-underline")], [
                    .i([
                        .u([
                            .fragment([
                                .text(element.content)
                            ] + (childNodesFromElement(element) ?? []))
                        ])
                    ])
                ]))
            case .boldItalic:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("bold-italic")], [
                    .b([
                        .i([
                            .fragment([
                                .text(element.content)
                            ] + (childNodesFromElement(element) ?? []))
                        ])
                    ])
                ]))
            case .bold:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("bold")], [
                    .b([
                        .fragment([
                            .text(element.content)
                        ] + (childNodesFromElement(element) ?? []))
                    ])
                ]))
            case .italic:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("italic")], [
                    .i([
                        .fragment([
                            .text(element.content)
                        ] + (childNodesFromElement(element) ?? []))
                    ])
                ]))
            case .underline:
                return Node(arrayLiteral: .span(attributes: [Attribute<Tag.Span>.class("underline")], [
                    .u([
                        .fragment([
                            .text(element.content)
                        ] + (childNodesFromElement(element) ?? []))
                    ])
                ]))
            }
        }
    }
    
    public func toHTML() -> String {
        var scriptNodes: [Node] = []
        
        for element in self.elements {
            scriptNodes.append(elementToHtml(element))
        }
        if let css = try? String(contentsOf: Bundle.module.url(forResource: "screenplay", withExtension: "css")!, encoding: .utf8) {
            let script = Node(arrayLiteral:
                    .document(
                        .html(
                            .head([
                                .style(unsafe: css)
                            ]),
                            .body([
                                .div(attributes: [Attribute<Tag.Div>.class("script")], [
                                    .fragment(scriptNodes)
                                ])
                            ])
                        )
                    )
            )
            return render(script)
        } else {
            return "Oh no!"
        }
    }

}
