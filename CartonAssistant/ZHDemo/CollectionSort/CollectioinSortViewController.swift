//
//  CollectioinSortViewController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/3/4.
//

import UIKit

class CollectioinSortViewController: UIViewController {
    lazy var collectionView: UICollectionView = makeCollectionView()
    
    var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        let backBtn = UIButton()
        backBtn.setTitle("返回", for: .normal)
        backBtn.backgroundColor = .systemOrange
        backBtn.layer.borderColor = UIColor.black.cgColor
        backBtn.layer.cornerRadius = 12
        backBtn.layer.borderWidth = 1
        backBtn.layer.masksToBounds = true
        backBtn.addTarget(self, action: #selector(backBtnDidTapped), for: .touchUpInside)
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.width.equalTo(70)
        }
    }
    
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 100, left: 24, bottom: 10, right: 24)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        
        return collectionView
    }
    
    @objc func backBtnDidTapped() {
        dismiss(animated: true)
    }
}

extension CollectioinSortViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let item = items[indexPath.item]
        cell.label.text = item
        cell.tagLabel.text = "\(indexPath.item + 1)"
        cell.tagView.isHidden = false
        return cell
    }
    
    // 实现其他必要的数据源方法
}

extension CollectioinSortViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 60
        return CGSize(width: width, height: 50)
    }
    
    // 实现其他必要的布局方法
}

extension CollectioinSortViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.item < items.count else {
            return []
        }
        
        let dragItem = UIDragItem(itemProvider: .init())
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
            cell.tagView.isHidden = true
        }
        
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = .clear
        previewParameters.visiblePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 60, height: 50), cornerRadius: 14)
        return previewParameters
    }
}

extension CollectioinSortViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        
        switch coordinator.proposal.operation {
        case .move:
            let items = coordinator.items
            if let item = items.first, let sourceIndexPath = item.sourceIndexPath {
                //执行批量更新
                collectionView.performBatchUpdates({
                    let item = self.items[sourceIndexPath.row]
                    
                    self.items.remove(at: sourceIndexPath.row)
                    self.items.insert(item, at: destinationIndexPath.row)
                    
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                })
                //将Cell使用动画移动到预期位置
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
            return
        default:
            return
        }
    }
    
    // Implement other necessary drop delegate methods
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard let destinationIndexPath else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
            cell.tagView.isHidden = true
        }
        
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = .clear
        previewParameters.visiblePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 60, height: 50), cornerRadius: 14)
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
        collectionView.reloadData()
    }
}

class Cell: UICollectionViewCell {
    let label: UILabel = UILabel(frame: .zero)
    let tagLabel: UILabel = UILabel(frame: .zero)
    let tagView = UIView()
    var position: CGPoint = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        bgView.layer.cornerRadius = 14.0
        //        contentView.clipsToBounds = true
        bgView.backgroundColor = .systemRed
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.textAlignment = .center
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tagView.backgroundColor = .systemOrange
        tagView.layer.cornerRadius = 10
        contentView.addSubview(tagView)
        tagView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerX.equalTo(contentView.snp.right)
            make.centerY.equalTo(contentView.snp.top)
        }
        
        tagLabel.textAlignment = .center
        tagView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
