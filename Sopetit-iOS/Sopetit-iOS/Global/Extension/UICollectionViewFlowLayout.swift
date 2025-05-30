//
//  UICollectionViewFlowLayout.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/30/25.
//

import UIKit

final class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?
            .map({ $0.copy() as! UICollectionViewLayoutAttributes })
        else { return nil }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1
        
        for attr in attributes where attr.representedElementCategory == .cell {
            if attr.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            attr.frame.origin.x = leftMargin
            leftMargin += attr.frame.width + minimumInteritemSpacing
            maxY = max(attr.frame.maxY, maxY)
        }
        return attributes
    }
}
