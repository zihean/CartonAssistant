//
//  Array+extension.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/28.
//

import Foundation

public extension Array {
    func object(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
}
