//
//  CategoryBar.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 05.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

protocol CategoryBarDelegate: class {
    func categoryBarButtonDidChangeState(_ view: CategoryBar, button: CategoryButton)
}

class CategoryBar: UIStackView {
    
    //MARK: Properties
    private var buttons: [CategoryButton] = []
    private var selectedStateImages: [CGImage] = []
    private var lastSelectedButtonIndex: Int?
    private var categorySelectedImage: UIImage?
    
    weak var delegate: CategoryBarDelegate?
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    
    //MARK: Private Methods
    private func configureView() {
        
        for category in Category.allValues {
            let categoryButton = CategoryButton()
            categoryButton.category = Category(rawValue: category)
            
            let categoryImage = UIImage(named: category)
            selectedStateImages.append((UIImage(named: category + "_big")?.cgImage)!)
            
            categoryButton.setImage(categoryImage, for: .normal)
            categoryButton.setImage(categoryImage, for: .highlighted)
            categoryButton.setImage(UIImage(), for: .selected)
    
            categoryButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            
            buttons.append(categoryButton)
            addArrangedSubview(categoryButton)
       
        }
    }
    
    //MARK: Methods
    @objc func categoryButtonTapped(_ button: CategoryButton) {
        if let index = lastSelectedButtonIndex {
            buttons[index].isSelected = false
            buttons[index].layer.sublayers?.last?.removeFromSuperlayer()
        }
        
        addLayerForSelectedState(button: button)
        delegate?.categoryBarButtonDidChangeState(self, button: button)
    }

    private func addLayerForSelectedState(button: CategoryButton) {
        let buttonIndex = buttons.index(of: button)!
        
        let layer = CAShapeLayer()
        let center = CGPoint(x: button.frame.width / 2, y: button.frame.height / 5)
        let path = UIBezierPath(arcCenter: center, radius: button.bounds.width / 2, startAngle: CGFloat(0), endAngle: CGFloat.pi, clockwise: false)
        layer.path = path.cgPath
        layer.fillColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        
        let imageLayer = CALayer()
        let frameHeightIndent = button.bounds.height / 12
        let frameWidthIndent = button.bounds.width / 4
        imageLayer.frame = CGRect(x: frameWidthIndent / 2, y: -frameHeightIndent, width: button.bounds.width - frameWidthIndent, height: button.bounds.height - frameHeightIndent * 2.5)
        imageLayer.contents = selectedStateImages[buttonIndex]
        
        layer.addSublayer(imageLayer)
        button.layer.addSublayer(layer)
        
        lastSelectedButtonIndex = buttonIndex
        
        button.isSelected = true
    }
}













