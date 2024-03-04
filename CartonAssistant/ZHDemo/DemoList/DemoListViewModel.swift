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
        let compositionalLayoutItem = DemoItemModel(title: "CompositionalLayout", destination: CompositionalLayoutViewController.description())
        let drag_dropItem = DemoItemModel(title: "Drag&Drop", destination: CollectioinSortViewController.description())
        items.append(contentsOf: [
            flowLayoutItem,
            compositionalLayoutItem,
            drag_dropItem
        ])
    }
}
