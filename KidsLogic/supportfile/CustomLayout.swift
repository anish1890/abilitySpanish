//
//  CustomLayout.swift
//  KidsLogic
//
//  Created by Anish on 1/20/24.
//

import Foundation
import UIKit


protocol CustomLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountForSection section: Int) -> Int
}

class CustomLayout: UICollectionViewFlowLayout {
    
     var columnCount: Int = 2
      var contentHeight: CGFloat = 0.0
     weak var delegate: CustomLayoutDelegate?
     var singleCellWidth: CGFloat = 0.0
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        minimumInteritemSpacing = 10.0
        minimumLineSpacing = 10.0
        sectionInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        columnCount = 2
        
        let itemWidth = (UIScreen.main.bounds.size.width - CGFloat((columnCount + 1)) * minimumInteritemSpacing) / CGFloat(columnCount)
        
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var itemAttributes = [UICollectionViewLayoutAttributes]()
        contentHeight = 0
        
        guard let itemCount = collectionView?.numberOfItems(inSection: 0) else {
            return nil
        }
        
        var columnHeights = [CGFloat](repeating: 0, count: columnCount)
        let minimumLineSpacing = minimumLineSpacingForSection(section: 0)
        let minimumInteritemSpacing = minimumInteritemSpacingForSection(section: 0)
        let sectionInset = sectionInsetForSection(section: 0)
        
        contentHeight += sectionInset.top
        
        for i in 0..<columnCount {
            columnHeights[i] = contentHeight
        }
        
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let columnIndex = columnHeights.firstIndex(of: columnHeights.min() ?? 0) ?? 0
            
            guard let size = itemSizeForIndexPath(indexPath: indexPath) else {
                continue
            }
            
            let x = sectionInset.left + (size.width + minimumInteritemSpacing) * CGFloat(columnIndex)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: x, y: columnHeights[columnIndex], width: size.width, height: size.height)
            itemAttributes.append(attributes)
            
            columnHeights[columnIndex] = attributes.frame.maxY + minimumLineSpacing
        }
        
        contentHeight = columnHeights.max() ?? 0.0
        
        if itemCount == 0 {
            contentHeight += UIScreen.main.bounds.size.height
        }
        
        contentHeight += sectionInset.bottom
        
        return itemAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.size.width ?? 0, height: contentHeight)
    }
    
    func sectionInsetForSection(section: Int) -> UIEdgeInsets {
        if let delegate = delegate, delegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))) {
            return delegate.collectionView!(collectionView!, layout: self, insetForSectionAt: section)
        } else {
            return sectionInset
        }
    }
    
    func minimumInteritemSpacingForSection(section: Int) -> CGFloat {
        if let delegate = delegate, delegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))) {
            return delegate.collectionView!(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: section)
        } else {
            return minimumInteritemSpacing
        }
    }
    
    func minimumLineSpacingForSection(section: Int) -> CGFloat {
        if let delegate = delegate, delegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumLineSpacingForSectionAt:))) {
            return delegate.collectionView!(collectionView!, layout: self, minimumLineSpacingForSectionAt: section)
        } else {
            return minimumLineSpacing
        }
    }
    
    func itemSizeForIndexPath(indexPath: IndexPath) -> CGSize? {
        if let delegate = delegate, delegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:sizeForItemAt:))) {
            return delegate.collectionView!(collectionView!, layout: self, sizeForItemAt: indexPath)
        } else {
            return itemSize
        }
    }
}
