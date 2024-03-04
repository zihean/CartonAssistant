//
//  UIEdgeInsets.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/3/1.
//

import UIKit

public extension UIEdgeInsets {
    static prefix func - (insets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: -insets.top,
                            left: -insets.left,
                            bottom: -insets.bottom,
                            right: -insets.right)
    }
}
