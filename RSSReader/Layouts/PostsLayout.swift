//
//  PostsLayout.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 02.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

protocol PostsLayoutDelegate: class {
    func collectionview(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PostsLayout: UICollectionViewLayout {
    
    //MARK: Properties
    weak var delegate: PostsLayoutDelegate!
    var numberOfColumns = 2
    var cellPadding: CGFloat = 8

    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var actualContentHeight: CGFloat?
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insents = collectionView.contentInset
        return collectionView.bounds.width - (insents.left + insents.right)
    }
    
    override var collectionViewContentSize: CGSize {
        if let height = actualContentHeight{
            return CGSize(width: contentWidth, height: height)
        }
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        if !cache.isEmpty {
            cache.removeAll()
        }
        
        let colunmWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * colunmWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView!.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let height = delegate.collectionview(collectionView!, heightForItemAtIndexPath: indexPath) + (cellPadding * 2)
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: colunmWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            actualContentHeight = yOffset[column]
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { (attributes) -> Bool in
            return attributes.frame.intersects(rect)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}














