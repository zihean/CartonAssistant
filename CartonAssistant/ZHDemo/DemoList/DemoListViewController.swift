//
//  DemoListViewController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/28.
//

import UIKit

class DemoListViewController: UIViewController {
    
    let viewModel: DemoListViewModel
    
    private lazy var demoList = makeDemoList()
    
    static func getList() -> DemoListViewController {
        let vm = DemoListViewModel()
        let vc = DemoListViewController(vm)
        return vc
    }
    
    init(_ viewModel: DemoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension DemoListViewController {
    func setupUI() {
        view.addSubview(demoList)
        demoList.snp.makeConstraints { make in
            make.top.equalTo(SafeAreaInsets.top)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func makeDemoList() -> UITableView {
        let view = UITableView(frame: .zero, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.getDescription())
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.contentInsetAdjustmentBehavior = .never
        view.sectionHeaderTopPadding = 0
        view.bounces = false
        return view
    }
}

extension DemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.getDescription(), for: indexPath)
        if let item = viewModel.items.object(at: indexPath.item) {
            cell.textLabel?.text = item.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel.items.object(at: indexPath.item),
           let destination = NSClassFromString(item.destination) as? UIViewController.Type {
            let vc = destination.init()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
