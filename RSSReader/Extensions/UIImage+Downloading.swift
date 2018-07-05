//
//  UIImage+Downloading.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 02.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

//import UIKit
//
//extension UIImage {
//    convenience init?(url: URL) {
//        do {
//            let data = try Data(contentsOf: url)
//            self.init(data: data)
//        } catch {
//            fatalError("Cannot download image: \(error)")
//        }
//    }
//    func downloadImage(byURL:URL, _ completion: @escaping (UIImage) -> Void) {
//        DispatchQueue.global(qos: .userInitiated).async {  in
//            do {
//                let data = try Data(contentsOf: url)
//                let image = UIImage.init(data: data)
//            } catch {
//                fatalError("Cannot download image: \(error)")
//            }
//            let data = try Data(contentsOf: url)
//            let image = UIImage.init(data: data)
//            completion(image)
//        }
//    }
//}
