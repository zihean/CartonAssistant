//
//  GlobalVariable  .swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/23.
//

import UIKit

public let onePixel: CGFloat = 1.0 / UIScreen.main.scale

public var SafeAreaInsets: UIEdgeInsets {
    if let keyWindow = UIApplication.shared.keyWindow {
        return keyWindow.safeAreaInsets
    } else {
        return .zero
    }
}
