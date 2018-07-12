//
//  PostCollectionViewCell.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    var link: String?
    
    @IBOutlet weak var imageDownload: UIActivityIndicatorView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    
    override func prepareForReuse() {
        postImage.image = nil
    }
    
    func setImage(by url: URL) {
        imageDownload.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            let image: UIImage?
            
            do{
                let data = try Data(contentsOf: url)
                image = UIImage.init(data: data)
            } catch {
                image = UIImage(named: "default")
            }
            
            DispatchQueue.main.async {
                self.postImage.image = image
                self.imageDownload.stopAnimating()
            }
        }
    }
    
}
