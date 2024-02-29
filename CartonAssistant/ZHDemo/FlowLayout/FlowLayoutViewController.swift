//
//  FlowLayoutViewController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/28.
//

import UIKit

class FlowLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

private extension FlowLayoutViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        let leftItem = ZHTopBar.ItemConfig(title: "返回") { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        let topBar = ZHTopBar(title: "FlowLayout",
                              leftItem: leftItem)
        topBar.setup(in: view)
    }
}
