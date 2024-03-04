//
//  CompositionalLayoutViewController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/3/4.
//

import UIKit

class CompositionalLayoutViewController: UIViewController {
    
    let data = [["妙蛙种子", "小火龙", "杰尼龟", "绿毛虫", "波波", "独角虫", "铁甲蛹", "大针蜂", "泥蛙", "三合一磁怪",
                "喵喵", "猫老大", "可达鸭", "哥达鸭", "猴怪", "火暴猴", "卡蒂狗", "风速狗", "蚊香蝌蚪", "蚊香君",
                "蝌蚪王", "暴鲤龙", "乘龙", "百变怪", "伊布", "水伊布", "雷伊布", "火伊布", "多边兽", "菊石兽",
                "多刺菊石兽", "化石盔", "镰刀盔", "化石翼龙", "卡比兽", "急冻鸟", "闪电鸟", "火焰鸟", "迷你龙", "哈克龙",
                "快龙", "超梦", "梦幻", "菊草叶", "月桂叶", "大菊花", "火球鼠", "火岩鼠", "火暴兽", "小锯鳄",
                "蓝鳄", "大力鳄", "尾立", "大尾立"],
                ["妙蛙种子", "小火龙", "杰尼龟", "绿毛虫", "波波", "独角虫", "铁甲蛹", "大针蜂", "泥蛙", "三合一磁怪",
                            "喵喵", "猫老大", "可达鸭", "哥达鸭", "猴怪", "火暴猴", "卡蒂狗", "风速狗", "蚊香蝌蚪", "蚊香君",
                            "蝌蚪王", "暴鲤龙", "乘龙", "百变怪", "伊布", "水伊布", "雷伊布", "火伊布", "多边兽", "菊石兽",
                            "多刺菊石兽", "化石盔", "镰刀盔", "化石翼龙", "卡比兽", "急冻鸟", "闪电鸟", "火焰鸟", "迷你龙", "哈克龙",
                            "快龙", "超梦", "梦幻", "菊草叶", "月桂叶", "大菊花", "火球鼠", "火岩鼠", "火暴兽", "小锯鳄",
                            "蓝鳄", "大力鳄", "尾立", "大尾立"]]
    let cellColors: [UIColor] = [.red, .blue, .green, .systemOrange, .systemPurple, .systemYellow]
    
    private lazy var collectionView = getCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

private extension CompositionalLayoutViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        // topbar
        let leftItem = ZHTopBar.ItemConfig(title: "返回") { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        let topBar = ZHTopBar(title: "CompositionalLayout",
                              leftItem: leftItem)
        topBar.setup(in: view)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func getCollectionView() -> UICollectionView {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] sectionIndex, environment in
            guard let self = self else { 
                return .init(group: .init(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))))
            }
            return self.makeSectionLayout(sectionIndex)
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        configuration.interSectionSpacing = 20
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
        layout.register(GroupBGReusableView.self, forDecorationViewOfKind: "GroupBGReusableView")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 0
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.getDescription())
        collectionView.register(FlowLayoutCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader")
        collectionView.panGestureRecognizer.maximumNumberOfTouches = 1
        return collectionView
    }
    
    func makeSectionLayout(_ index: Int) -> NSCollectionLayoutSection {
        switch index {
        case 0:
            // 左列
            let layoutSize_0 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120))
            let item_0 = NSCollectionLayoutItem(layoutSize: layoutSize_0)
            
            // 右列第一行
            let layoutSize_1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item_1 = NSCollectionLayoutItem(layoutSize: layoutSize_1)
            let subGroupSize_0_0 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let subGroup_0_0 = NSCollectionLayoutGroup.horizontal(layoutSize: subGroupSize_0_0, subitems: [item_1, item_1])
            // 右列第二行
            let layoutSize_2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3), heightDimension: .fractionalHeight(1))
            let item_2 = NSCollectionLayoutItem(layoutSize: layoutSize_2)
            let subGroupSize_0_1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let subGroup_0_1 = NSCollectionLayoutGroup.horizontal(layoutSize: subGroupSize_0_1, subitems: [item_2, item_2, item_2])
            // 右列
            let subGroupSize_0 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120))
            let subGroup_0 = NSCollectionLayoutGroup.vertical(layoutSize: subGroupSize_0, subitems: [subGroup_0_0, subGroup_0_1])
            // group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item_0, subGroup_0])
            // group header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            group.supplementaryItems = [sectionHeader]
            group.contentInsets = .init(top: 30, leading: 20, bottom: 20, trailing: 20)
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        case 1:
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
            let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { environment in
                let size = environment.container.contentSize
                let itemWidth = size.width - 20 * 2 - 2 * 12
                let itemHeight = size.height - 2 * 12 - 2 * 12
                let item_0 = NSCollectionLayoutGroupCustomItem.init(frame: .init(x: 12, y: 12, width: itemWidth, height: itemHeight), zIndex: 1)
                let item_1 = NSCollectionLayoutGroupCustomItem.init(frame: .init(x: 12 + 20, y: 12 + 12, width: itemWidth, height: itemHeight), zIndex: 2)
                let item_2 = NSCollectionLayoutGroupCustomItem.init(frame: .init(x: 12 + 20 * 2, y: 12 + 12 * 2, width: itemWidth, height: itemHeight), zIndex: 3)
                let bgItem = NSCollectionLayoutGroupCustomItem(frame: .init(x: 5, y: 5, width: size.width - 10, height: size.height - 10), zIndex: 0)
                return [bgItem, item_0, item_1, item_2]
            }
            group.interItemSpacing = .fixed(20)
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            return section
        default:
            return .init(group: .init(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))))
        }
    }
}

extension CompositionalLayoutViewController: UICollectionViewDelegate {
    
}

extension CompositionalLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            let count = data.object(at: section)?.count ?? 0
            let numberOfGroup = Int(floor(Double(count - 1) / 3)) + 1
            if count <= 0 {
                return 0
            } else {
                return numberOfGroup + count
            }
        } else {
            return data.object(at: section)?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowLayoutCell.getDescription(), for: indexPath)
        
        if let flowLayoutCell = cell as? FlowLayoutCell {
            if indexPath.section == 1 {
                let x = indexPath.item % 4
                if x <= 0 {
                    cell.backgroundColor = .systemOrange
                    cell.layer.cornerRadius = 20
                } else {
                    let indexOfGroup = indexPath.item / 4
                    let realIndex = indexOfGroup * 3 + x - 1
                    flowLayoutCell.label.text = data.object(at: indexPath.section)?.object(at: realIndex)
                    cell.backgroundColor = cellColors[(realIndex % 3)]
                }
            } else {
                flowLayoutCell.label.text = data.object(at: indexPath.section)?.object(at: indexPath.item)
                cell.backgroundColor = cellColors[(indexPath.row % 6)]
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView: UICollectionReusableView
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader", for: indexPath)
            if let cell = header as? FlowLayoutCell {
                cell.label.text = data.object(at: indexPath.section)?.object(at: indexPath.item * 6)
            }
            reusableView = header
        case "GroupBGReusableView":
            let bgView = collectionView.dequeueReusableSupplementaryView(ofKind: "GroupBGReusableView", withReuseIdentifier: "GroupBGReusableView", for: indexPath)
            reusableView = bgView
        default:
            reusableView = .init()
        }
        
        return reusableView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
}
