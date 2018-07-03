//
//  RSSParser.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import Foundation

class RSSParser: NSObject {
    
    private var parser: XMLParser
    
    private(set) var posts: [Post] = []
    private var tempPost: Post?
    private var tempElement: String?
    
    init(url: URL) {
        parser = XMLParser(contentsOf: url)!
    }
    
    func parse() {
        parser.delegate = self
        parser.parse()
    }
    
}

extension RSSParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        fatalError("Parse error \(parseError)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tempElement = elementName
        
        if elementName == RSSElements.item {
            tempPost = Post()
        }
        
        if tempPost != nil, elementName == RSSElements.enclosure {
            if attributeDict[RSSElements.typeAttribute] == RSSElements.imageType {
                tempPost?.imageURL = URL(string: attributeDict[RSSElements.urlAttribute]!)
            }
        }
    
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == RSSElements.item {
            if let post = tempPost {
                posts.append(post)
            }
            
            tempPost = nil
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        if tempElement == "category", !string.contains("\n") {
//
//        }
        
        if tempPost != nil {
            
            if tempElement == RSSElements.title, !string.contains("\n") {
                tempPost?.title += string
            }
            
            if tempElement == RSSElements.description, !string.contains("\n") {
                tempPost?.description += string
            }

        }
    }
    
    
}
