//
//  CustomCVLayout.swift
//  SeedAppInterView
//
//  Created by chad chen on 2018-08-29.
//  Copyright © 2018 chad chen. All rights reserved.
//

import UIKit

protocol CustomLayoutDelegate: class {
        func collectionView(_ collectionView: UICollectionView, imageHeightAtIndex index: IndexPath) -> CGFloat
}

class CustomLayout: UICollectionViewLayout {
    //delegate
    weak var delegate: CustomLayoutDelegate!
    
    //variables
    private var numberOfColumns: Int = 2
    static var cellPadding: CGFloat = 5
    
    //Array to keep a cache of UICollectionViewLayoutAttributes.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //Content height and size
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        //Make sure collectionView ready
        guard let collectionView = collectionView else {
            return
        }
        //Clear cache
        cache = []
        //Property setup
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        //Calculation
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate.collectionView(collectionView, imageHeightAtIndex: indexPath)
            let height = CustomLayout.cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: CustomLayout.cellPadding, dy: CustomLayout.cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
