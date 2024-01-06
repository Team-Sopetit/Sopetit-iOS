//
//  UICollectionViewRegisterable.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

protocol UICollectionViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
    static func dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self
}

extension UICollectionViewRegisterable where Self: UICollectionViewCell {
    static func register(target: UICollectionView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forCellWithReuseIdentifier: Self.className)
        } else {
            target.register(self, forCellWithReuseIdentifier: Self.className)
        }
    }
    
    static func dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.className, for: indexPath) as? Self else { fatalError()}
        return cell
    }
}

protocol UICollectionHeaderViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
    static func dequeueReusableHeaderView(collectionView: UICollectionView, indexPath: IndexPath) -> Self
}

extension UICollectionHeaderViewRegisterable where Self: UICollectionReusableView {
    static func register(target: UICollectionView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.className)
        } else {
            target.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.className)
        }
    }
    
    static func dequeueReusableHeaderView(collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: self.className,
            for: indexPath) as? Self else { return UICollectionReusableView() as! Self }
        return headerView
    }
}

protocol UICollectionFooterViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
    static func dequeueReusableFooterView(collectionView: UICollectionView, indexPath: IndexPath) -> Self
}

extension UICollectionFooterViewRegisterable where Self: UICollectionReusableView {
    static func register(target: UICollectionView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Self.className)
        } else {
            target.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Self.className)
        }
    }
    
    static func dequeueReusableFooterView(collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: self.className,
            for: indexPath) as? Self else { return UICollectionReusableView() as! Self }
        return footerView
    }
}
