//
//  SourceCollectionViewCell.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 10.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class SourceCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    var id: MenuSections?
    @IBOutlet weak var sourceLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sourceLabel.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        }
    }
}
