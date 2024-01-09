//
//  TabBarController.swift
//
//

import Foundation

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let tabBarHeight: CGFloat = 84
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        setTabBarUI()
        setTabBarHeight()
    }
    
}

private extension TabBarController {
    
    func setTabBarItems() {
        
        // 해당 viewcontroller들이 없을 경우 ViewController()로 모두 대체해서 빌드하십시오
//        let dailyVC = UINavigationController(rootViewController: DailyViewController())
//        let homeVC = HomeViewController()
//        let happyVC = HappyRoutineViewController()
        let dailyVC = UINavigationController(rootViewController: ViewController())
        let homeVC = ViewController()
        let happyVC = HappyRoutineViewController()
        
        tabs = [
            dailyVC,
            homeVC,
            happyVC
        ]
        
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
            tabs[$0.rawValue].tabBarItem = tabBarItem
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        let tabBarItemTitles: [String] = ["데일리 루틴", "홈", "행복 루틴"]
        
        for (index, tabTitle) in tabBarItemTitles.enumerated() {
            let tabBarItem = TabBarItemType(rawValue: index)?.setTabBarItem()
            tabs[index].tabBarItem = tabBarItem
            tabs[index].tabBarItem.tag = index
            tabs[index].title = tabTitle // Set the title for the tab bar item
        }
        
        setViewControllers(tabs, animated: false)

    }
    
    func setTabBarUI() {
//        UITabBar.clearShadow()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .SoftieMain1
    }
    
    func getSafeAreaBottomHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets
            let bottomSafeAreaHeight = safeAreaInsets?.bottom ?? 0
            return bottomSafeAreaHeight
        }
        return 0
    }
    
    func setTabBarHeight() {
        if let tabBar = self.tabBarController?.tabBar {
            let safeAreaBottomInset = self.view.safeAreaInsets.bottom
            let tabBarHeight = tabBar.bounds.height
            let newTabBarFrame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y, width: tabBar.frame.width, height: tabBarHeight + safeAreaBottomInset)
            tabBar.frame = newTabBarFrame
        }
    }
}
