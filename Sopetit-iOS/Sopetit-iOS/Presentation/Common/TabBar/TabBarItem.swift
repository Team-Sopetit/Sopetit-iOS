//
//  TabBarItem.swift
//
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case actionList
    case myPage
}

extension TabBarItemType {
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .actionList:
            return UIImage(systemName: "checkmark.seal.fill")!
        case .myPage:
            return UIImage(systemName: "sparkles")!
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .actionList:
            return UIImage(systemName: "checkmark.seal.fill")!
        case .myPage:
            return UIImage(systemName: "sparkles")!
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "", image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
