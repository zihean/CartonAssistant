//
//  DemoListViewModel.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/28.
//

import Foundation

class DemoListViewModel {
    var items: [DemoItemModel] = []
    init() {
        setupList()
    }
}

private extension DemoListViewModel {
    func setupList() {
        let flowLayoutItem = DemoItemModel(title: "FlowLayout", destination: FlowLayoutViewController.description())
        items.append(flowLayoutItem)
    }
}
