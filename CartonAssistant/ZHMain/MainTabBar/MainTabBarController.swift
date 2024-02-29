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
    var tabList: [MainTabItem.TabType] = [] {
        didSet {
            let vcs = tabList.map({ getTabVC(type: $0) })
            let items = tabList.map({ MainTabItem(type: $0) })
            viewControllers = vcs
            mainTabBar.resetTabs(items: items)
        }
    }

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
        selectedIndex = tabList.firstIndex(where: { $0 == selected }) ?? 0
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
        tabList = [defaultTab]
        updateMainTabBar(selected: defaultTab)
    }
    
    func setupTabs() {
        let tabs: [MainTabItem.TabType] = [.demo, .account, .my]
        tabList = tabs
    }
    
    func getTabVC(type: MainTabItem.TabType) -> ZHNavigationController {
        let navVC: ZHNavigationController
        switch type {
        case .demo:
            let demoListVC = DemoListViewController.getList()
            navVC = ZHNavigationController(rootViewController: demoListVC)
        case .my:
            navVC = ZHNavigationController(rootViewController: UIViewController())
        case .account:
            navVC = ZHNavigationController(rootViewController: UIViewController())
        }
        return navVC
    }
}

extension MainTabBarController: MainTabBarDelegate {
    func mainTabBar(_ tabbar: MainTabBar, didSelect: MainTabItem.TabType) {
        updateMainTabBar(selected: didSelect)
    }
}
