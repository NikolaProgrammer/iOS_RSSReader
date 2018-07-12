//
//  RSSParser.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import Foundation

fileprivate struct RSSElements {
    static let item = "item"
    static let title = "title"
    static let description = "description"
    static let enclosure = "enclosure"
    static let link = "link"
    static let thumbnail = "media:thumbnail"
    
    static let typeAttribute = "type"
    static let urlAttribute = "url"
    
    static let imageType = "image/jpeg"
}


class RSSParser: NSObject {
    
    private var parser: XMLParser
    
    private(set) var posts: [Post] = []
    private var tempPost: Post?
    private var tempElement: String?
    private var sourceTitle: String!
    
    private let  categoryNames = [
        "auto" : ["Авто", "Автоновости"],
        "world" : ["Мир", "Путешествия", "В мире", "Кругозор", "Происшествия", "Силовые структуры", "Россия"],
        "sport" : ["Футбол", "Теннис", "Хоккей на траве", "Легкая атлетика", "Хоккей", "Околоспорт", "Спорт"],
        "immovables" : ["Недвижимость"],
        "technologies" : ["Технологии", "Гаджеты", "Наука", "Интернет и связь", "Оружие", "Наука и техника"],
        "society" : ["Люди", "Общество", "Из жизни", "Бывший СССР", "Интернет и СМИ", "Культура"],
        "finance" : ["Деньги и власть", "Публичный счет", "Экономика", "Ценности"]
    ]
    
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
        
        if tempPost != nil, elementName == RSSElements.thumbnail {
            tempPost?.imageURL = URL(string: attributeDict[RSSElements.urlAttribute]!)
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
        if tempPost != nil {
            if tempElement == RSSElements.title, !string.contains("\n") {
                tempPost?.title += string
            }
            if tempElement == RSSElements.description, !string.contains("\n") {
                tempPost?.description += string
            }
            if tempElement == RSSElements.link, !string.contains("\n") {
                tempPost?.link += string
            }
            if tempElement == "category", !string.contains("\n") {
                for (category, names) in categoryNames {
                    for name in names {
                        if string == name {
                            tempPost?.category = Category(rawValue: category)
                        }
                    }
                }
            }
        } else {
            if tempElement == RSSElements.title, !string.contains("\n"), sourceTitle == nil {
                sourceTitle = string.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: " ", with: "")
            }
        }
    }
    
    
}
