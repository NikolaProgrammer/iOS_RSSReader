//
//  CategoryButton.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 10.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class CategoryButton: UIButton {

    //MARK: Properties
    var category: Category?
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    //MARK: Private Methods
    private func configureView() {
        backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)        
    }
}
