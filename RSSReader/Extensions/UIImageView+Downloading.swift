//
//  UIImageView+Downloading.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 05.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(by url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            let image = UIImage.init(data: data!)
            DispatchQueue.main.async {
               self.image = image
            }
        }
    }
}
