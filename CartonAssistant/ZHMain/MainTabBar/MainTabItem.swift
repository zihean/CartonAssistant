//
//  File.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/23.
//

import Foundation

public class MainTabItem {
    public enum TabType {
        case my
        case demo
        case account    // 记账
    }
    
    let type: TabType
    
    lazy var defaultImageName: String = getDefaultImageName()
    lazy var selectedImageName: String = getSelectedImageName()
    lazy var title: String = getTitle()
    
    init(type: TabType) {
        self.type = type
    }
}

private extension MainTabItem {
    func getDefaultImageName() -> String {
        switch type {
        case .demo:
            return ""
        case .account:
            return ""
        case .my:
            return ""
        }
    }
    
    func getSelectedImageName() -> String {
        switch type {
        case .demo:
            return ""
        case .account:
            return ""
        case .my:
            return ""
        }
    }
    
    func getTitle() -> String {
        switch type {
        case .demo:
            return "Demo"
        case .account:
            return "记账"
        case .my:
            return "我的"
        }
    }
}
