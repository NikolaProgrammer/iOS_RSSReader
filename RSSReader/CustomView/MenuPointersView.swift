//
//  menuPointersView.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 03.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class MenuPointersView: UIView {

    var isActive = false {
        didSet {
            toggleActiveStatus()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let halfRectWidth = rect.size.width * 0.5
        let rectHeight = rect.size.height
        
        let drawningRectWidth = CGFloat(4)
        let drawingRectSize = CGSize(width: drawningRectWidth, height: rectHeight * 0.3)
        drawRect(rectSize: drawingRectSize, origin: CGPoint(x: halfRectWidth - (drawningRectWidth / 2), y: CGFloat(0)))
        drawRect(rectSize: drawingRectSize, origin: CGPoint(x: halfRectWidth - (drawningRectWidth / 2), y: rectHeight * 0.7))
        
        let rectCenter = CGPoint(x: halfRectWidth, y: rectHeight * 0.5)
        let radius = rectHeight * 0.11
        
        let shape = CAShapeLayer()
        let circle = UIBezierPath(arcCenter: rectCenter, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
        shape.fillColor = #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1)
        shape.path = circle.cgPath
        layer.addSublayer(shape)

    }
    
    //MARK: Private Methods
    private func toggleActiveStatus() {
        if isActive {
            (layer.sublayers![0] as! CAGradientLayer).colors = [#colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
            (layer.sublayers![1] as! CAGradientLayer).colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor]
            (layer.sublayers![2] as! CAShapeLayer).fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            (layer.sublayers![0] as! CAGradientLayer).colors = [#colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor, #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor]
            (layer.sublayers![1] as! CAGradientLayer).colors = [#colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor, #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor]
            (layer.sublayers![2] as! CAShapeLayer).fillColor = #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1)
        }
    }
    
    private func drawRect(rectSize: CGSize, origin: CGPoint) {
        
        let shape = CAGradientLayer()
        shape.frame = CGRect(origin: origin, size: rectSize)
        shape.colors = [#colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor, #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1).cgColor]
        
        layer.addSublayer(shape)
        
//        shape.backgroundColor = #colorLiteral(red: 0.7498123468, green: 0.7498123468, blue: 0.7498123468, alpha: 1)
        
    }
}
