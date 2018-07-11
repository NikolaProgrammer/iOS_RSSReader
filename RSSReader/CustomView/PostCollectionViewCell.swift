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
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    
    
}
