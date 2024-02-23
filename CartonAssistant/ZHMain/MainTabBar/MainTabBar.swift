//
//  MainTabBar.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/23.
//

import UIKit
import SnapKit

public protocol MainTabBarDelegate: AnyObject {
    func mainTabBar(_ tabbar: MainTabBar, didSelect: MainTabItem.TabType)
}

public class MainTabBar: UITabBar {

    public weak var mainDelegate: MainTabBarDelegate?
    public var selectedTab: MainTabItem.TabType? = nil
    
    private let bgView = UIView()
    public private(set) var buttons = [MainTabButton]()
    private lazy var containerView = makeContainerView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(bgView)
    }
}

public extension MainTabBar {
    func resetTabs(items: [MainTabItem]) {
        let itemTypes = items.map({ $0.type })
        let curItemTypes: [MainTabItem.TabType] = buttons.map({ $0.item.type })
        guard itemTypes != curItemTypes else {
            return
        }
        
        buttons.forEach({ $0.removeFromSuperview() })
        buttons = []
        items.forEach { item in
            let button = getButton(item: item)
            self.containerView.addArrangedSubview(button)
            self.buttons.append(button)
        }
    }
    
    func update(selected: MainTabItem.TabType?) {
        guard selected != selectedTab else {
            return
        }
        
        selectedTab = selected
        buttons.forEach({
            $0.isSelected = $0.item.type == selected
        })
    }
}

private extension MainTabBar {
    func setupUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        backgroundColor = .systemBackground
        
        let splitView = UIView()
        splitView.backgroundColor = .systemGray
        bgView.addSubview(splitView)
        splitView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(onePixel)
        }
    }
    
    func getButton(item: MainTabItem) -> MainTabButton {
        let button = MainTabButton(item: item)
        button.isSelected = selectedTab == item.type
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchDown)
        return button
    }
    
    func makeContainerView() -> UIStackView {
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.distribution = .fillEqually
        return containerView
    }
}

private extension MainTabBar {
    @objc func buttonClicked(_ button: MainTabButton) {
        let to = button.item.type
        mainDelegate?.mainTabBar(self, didSelect: to)
    }
}
