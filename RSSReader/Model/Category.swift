//
//  Category.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 05.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import Foundation

enum Category: String {
    case finance
    case society
    case technologies
    case immovables
    case sport
    case auto
    case world
    
    static let allValues = ["finance", "society", "technologies", "immovables", "sport", "auto", "world"]
    
    var categoryName: String {
        let name: String
        
        switch self {
        case .auto:
            name = "Авто"
        case .finance:
            name = "Финансы"
        case .immovables:
            name = "Недвижимость"
        case .society:
            name = "Общество"
        case .sport:
            name = "Спорт"
        case .technologies:
            name = "Технологии"
        case .world:
            name = "Мир"
        }
        
        return name
    }
}
