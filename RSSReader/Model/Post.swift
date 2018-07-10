//
//  Post.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import Foundation

struct Post {
    var title: String = ""
    var imageURL: URL? 
    var link: URL?
    var description: String = ""
    var category: Category?
}
