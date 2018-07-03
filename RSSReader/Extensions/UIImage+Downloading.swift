//
//  UIImage+Downloading.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 02.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            fatalError("Cannot download image: \(error)")
        }
    }
}
