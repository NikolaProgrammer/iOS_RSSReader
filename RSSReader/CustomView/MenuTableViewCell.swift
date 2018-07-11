//
//  MenuTableViewCell.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 03.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    var section: MenuSections?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointersView: MenuPointersView!
    
}
