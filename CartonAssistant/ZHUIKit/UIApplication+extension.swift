//
//  UIApplication+extension.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/28.
//

import UIKit

public extension UIApplication {
    var keyWindow: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first {
            return keyWindow
        } else {
            return nil
        }
    }
}
