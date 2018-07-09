//
//  CategoryBar.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 05.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class CategoryBar: UIStackView {
    
    //MARK: Properties
    private var buttons: [UIButton] = []
    private var selectedStateImages: [CGImage] = []
    private var lastSelectedButtonIndex: Int?
    private var categorySelectedImage: UIImage?
    
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
            let categoryButton = UIButton()
            
            let categoryImage = UIImage(named: category)
            selectedStateImages.append((UIImage(named: category + "_big")?.cgImage)!)
            
            categoryButton.setImage(categoryImage, for: .normal)
            categoryButton.setImage(categoryImage, for: .highlighted)
            categoryButton.setImage(UIImage(), for: .selected)
            categoryButton.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            categoryButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            categoryButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            
            buttons.append(categoryButton)
            addArrangedSubview(categoryButton)
       
        }
    }
    
    //MARK: Private Methods
    @objc private func categoryButtonTapped(_ button: UIButton) {
        if let index = lastSelectedButtonIndex {
            buttons[index].isSelected = false
            buttons[index].layer.sublayers?.last?.removeFromSuperlayer()
        }
        
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

        button.isSelected = true
        lastSelectedButtonIndex = buttonIndex
    }
}













