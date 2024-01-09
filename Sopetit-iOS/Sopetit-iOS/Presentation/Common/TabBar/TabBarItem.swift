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
            return ImageLiterals.BottomNavi.icNavi1
        case .actionList:
            return ImageLiterals.BottomNavi.icNavi2
        case .myPage:
            return ImageLiterals.BottomNavi.icNavi3
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return ImageLiterals.BottomNavi.icNavi1Filled
        case .actionList:
            return ImageLiterals.BottomNavi.icNavi2Filled
        case .myPage:
            return ImageLiterals.BottomNavi.icNavi3Filled
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "", image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
