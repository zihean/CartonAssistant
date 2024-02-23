//
//  MainTabBarController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/22.
//

import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    
    internal lazy var mainTabBar = MainTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        DispatchQueue.main.async {
            self.setupTabs()
        }
    }
}

extension MainTabBarController {
    func updateMainTabBar(selected: MainTabItem.TabType?) {
        mainTabBar.update(selected: selected)
    }
}

private extension MainTabBarController {
    func setupUI() {
        mainTabBar.mainDelegate = self
        setValue(mainTabBar, forKey: "tabBar")
        
        tabBar.isTranslucent = false // tabbar不透明
        tabBar.barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        setupFirstLaunchTabs()
    }
    
    func setupFirstLaunchTabs() {
        let defaultTab: MainTabItem.TabType = .demo
        let defaultVC = getTabVC(type: defaultTab)
        let defaultItem = MainTabItem(type: defaultTab)
        viewControllers = [defaultVC]
        mainTabBar.resetTabs(items: [defaultItem])
        mainTabBar.update(selected: defaultTab)
    }
    
    func setupTabs() {
        let tabs: [MainTabItem.TabType] = [.demo, .account, .my]
        let vcs = tabs.map({ getTabVC(type: $0) })
        let items = tabs.map({ MainTabItem(type: $0) })
        viewControllers = vcs
        mainTabBar.resetTabs(items: items)
    }
    
    func getTabVC(type: MainTabItem.TabType) -> ZHNavigationController {
        let navVC: ZHNavigationController
        switch type {
        case .demo:
            navVC = ZHNavigationController()
        case .my:
            navVC = ZHNavigationController()
        case .account:
            navVC = ZHNavigationController()
        }
        return navVC
    }
}

extension MainTabBarController: MainTabBarDelegate {
    func mainTabBar(_ tabbar: MainTabBar, didSelect: MainTabItem.TabType) {
        updateMainTabBar(selected: didSelect)
    }
}
