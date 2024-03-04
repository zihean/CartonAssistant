//
//  CollectioinSortViewController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/3/4.
//

import UIKit

class CollectioinSortViewController: UIViewController {
    lazy var collectionView: UICollectionView = makeCollectionView()
    
    var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
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
//        cell.backgroundColor = UIColor.lightGray
//        cell.layer.cornerRadius = 8.0
//        cell.clipsToBounds = true
        
        let item = items[indexPath.item]
        cell.label.text = item
        
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
        guard indexPath.item < items.count - 1 else {
            return []
        }
        let item = items[indexPath.item]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = collectionView.cellForItem(at: indexPath)
        return [dragItem]
    }
    
    // 实现其他必要的拖动代理方法
}

extension CollectioinSortViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        
        switch coordinator.proposal.operation {
        case .copy:
            //执行批量更新
            collectionView.performBatchUpdates({
                var indexPaths = [IndexPath]()
                for (index, item) in coordinator.items.enumerated() {
                    guard let sourceIndexPath = item.sourceIndexPath else {
                        continue
                    }
                    let itemm = self.items[sourceIndexPath.row]
                    
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                    self.items.insert(itemm, at: indexPath.row)
//                    self.itemNames[destinationIndexPath.section]!.insert(item.dragItem.localObject as! String, at: indexPath.row)
                    indexPaths.append(indexPath)
                }
                collectionView.insertItems(at: indexPaths)
            })
            return
        case .move:
            let items = coordinator.items
            if let item = items.first, let sourceIndexPath = item.sourceIndexPath {
                //执行批量更新
                collectionView.performBatchUpdates({
                    let item = self.items[sourceIndexPath.row]
                    
                    self.items.remove(at: sourceIndexPath.row)
                    self.items.insert(item, at: destinationIndexPath.row)
                    
//                    self.itemNames[destinationIndexPath.section]!.remove(at: sourceIndexPath.row)
//                    self.itemNames[destinationIndexPath.section]!.insert(item.dragItem.localObject as! String, at: destinationIndexPath.row)
                    
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                })
                //将项目动画化到视图层次结构中的任意位置
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
            return
        default:
            return
        }
        
        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath,
                  let cell = dropItem.dragItem.localObject as? Cell else {
                return
            }
            
//            let item = items[sourceIndexPath.row]
//            items.remove(at: sourceIndexPath.row)
//            items.insert(item, at: destinationIndexPath.row)
//
//            let framee = collectionView.cellForItem(at: destinationIndexPath)?.frame ?? .zero
//            let shot = cell.snapshotView(afterScreenUpdates: false)
//            if let shot {
//                shot.frame = CGRect(origin: coordinator.session.location(in: collectionView), size: cell.frame.size)
//                collectionView.addSubview(shot)
//            }
//            cell.frame = CGRect(origin: coordinator.session.location(in: collectionView), size: cell.frame.size)
//            cell.alpha = 0
//
//            UIView.animate(withDuration: 0.3) {
//                shot?.frame = framee
//            }
//
//            collectionView.performBatchUpdates {
//                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
//            } completion: { [weak self] _ in
//                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
//                self?.collectionView.reloadData()
//    //            self?.reportAction(action: Tracker.MediumVideo.Action.organizeDone)
//            }
            
//            let item = items[sourceIndexPath.row]
//            let targetFrame = collectionView.cellForItem(at: destinationIndexPath)?.frame ?? .zero
//
//            self.items.remove(at: sourceIndexPath.row)
//            self.items.insert(item, at: destinationIndexPath.row)
//
//            let anima = coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
//            anima.addAnimations {
//                cell.frame = targetFrame
//            }
//
//            anima.addCompletion { [weak self] po in
//                guard let self = self else { return }
//                self.collectionView.reloadData()
//            }
//
            
//             3
            collectionView.performBatchUpdates({
                let item = items[sourceIndexPath.row]
                
                items.remove(at: sourceIndexPath.row)
                items.insert(item, at: destinationIndexPath.row)
                
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: { _ in
              // 4
                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
            })
            
        }
    }
    
    // Implement other necessary drop delegate methods
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard let destinationIndexPath,
              items.count > destinationIndexPath.row + 1 || (items.count == 1 && destinationIndexPath.row == 0) else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = .clear
        previewParameters.visiblePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 60, height: 50), cornerRadius: 14)
        return previewParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, dropPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = .clear
        previewParameters.visiblePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 60, height: 50), cornerRadius: 14)
        return previewParameters
    }
}

class Cell: UICollectionViewCell {
    let label: UILabel
    var position: CGPoint = .zero
    
    override init(frame: CGRect) {
        label = UILabel(frame: .zero)
        
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
        
//        contentView.backgroundColor = UIColor.lightGray
//        contentView.layer.cornerRadius = 8.0
//        contentView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
