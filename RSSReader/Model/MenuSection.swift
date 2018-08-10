//
//  MenuTitles.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 04.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import Foundation

enum MenuSections: String {
    case tut = "TUT.by"
    case onliner = "Onliner.by"
    case lenta = "Lenta.ru"
    case offerPost = "Предложить новость"
    case aboutUs = "О нас"
    
    static var allValues = ["TUT.by", "Onliner.by", "Lenta.ru", "Предложить новость", "О нас"]
    
    var url: String {
        var url: String
        
        switch self {
        case .tut:
            url = "https://news.tut.by/rss/all.rss"
        case .onliner:
            url = "https://www.onliner.by/feed"
        case .lenta:
            url = "http://lenta.ru/rss"
        default:
            fatalError("This is not post page \(self.rawValue)")
        }
        
        return url
    }
}

