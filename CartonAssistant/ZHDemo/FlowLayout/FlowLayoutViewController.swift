//
//  FlowLayoutViewController.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/28.
//

import UIKit

class FlowLayoutViewController: UIViewController {
    
    static let data = [["妙蛙种子", "小火龙", "杰尼龟", "绿毛虫", "波波", "独角虫", "铁甲蛹", "大针蜂", "泥蛙", "三合一磁怪",
                "喵喵", "猫老大", "可达鸭", "哥达鸭", "猴怪", "火暴猴", "卡蒂狗", "风速狗", "蚊香蝌蚪", "蚊香君",
                "蝌蚪王", "暴鲤龙", "乘龙", "百变怪", "伊布", "水伊布", "雷伊布", "火伊布", "多边兽", "菊石兽",
                "多刺菊石兽", "化石盔", "镰刀盔", "化石翼龙", "卡比兽", "急冻鸟", "闪电鸟", "火焰鸟", "迷你龙", "哈克龙",
                "快龙", "超梦", "梦幻", "菊草叶", "月桂叶", "大菊花", "火球鼠", "火岩鼠", "火暴兽", "小锯鳄",
                "蓝鳄", "大力鳄", "尾立", "大尾立"]]
    static let mat = [
                        ["妙蛙种子", "小火龙", "杰尼龟", "绿毛虫", "波波"],
                        ["喵喵", "猫老大", "可达鸭", "哥达鸭", "猴怪"],
                        ["小锯鳄", "蓝鳄", "大力鳄", "尾立", "大尾立"]
                     ]
    
    let data = [mat, data, data, mat]
    let cellColors: [UIColor] = [.red, .blue, .green]
    let cellHeights: [CGFloat] = [100, 170, 190, 60, 100]
    
    lazy var normalCollectionView = getNormalCollectionView()
    lazy var doubleFlowCollectionView = getDoubleFlowCollectionView()
    lazy var doubleFeedCollectionView = getDoubleFeedCollectionView()
    lazy var groupCollectionView = getGroupCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

private extension FlowLayoutViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        // topbar
        let leftItem = ZHTopBar.ItemConfig(title: "返回") { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        let topBar = ZHTopBar(title: "FlowLayout",
                              leftItem: leftItem)
        topBar.setup(in: view)
        
        let scrollView = UIScrollView()
        scrollView.bounces  = false
        scrollView.contentSize = .init(width: UIScreen.main.bounds.width, height: 0)
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        var lastView: UIView
        
        //
        let titleLabel_0 = UILabel()
        titleLabel_0.text = "普通CollectionView"
        titleLabel_0.textColor = .black
        scrollView.addSubview(titleLabel_0)
        titleLabel_0.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
        lastView = titleLabel_0
        
        scrollView.addSubview(normalCollectionView)
        normalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(250)
            make.left.right.centerX.equalToSuperview()
        }
        lastView = normalCollectionView
        
        
        // 双列CollectionView
        let titleLabel_1 = UILabel()
        titleLabel_1.text = "双列CollectionView"
        titleLabel_1.textColor = .black
        scrollView.addSubview(titleLabel_1)
        titleLabel_1.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(40)
        }
        lastView = titleLabel_1
        
        scrollView.addSubview(doubleFlowCollectionView)
        doubleFlowCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(250)
            make.left.right.centerX.equalToSuperview()
        }
        lastView = doubleFlowCollectionView
        
        
        // 双列Feed
        let titleLabel_2 = UILabel()
        titleLabel_2.text = "双列Feed"
        titleLabel_2.textColor = .black
        scrollView.addSubview(titleLabel_2)
        titleLabel_2.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(40)
        }
        lastView = titleLabel_2
        
        scrollView.addSubview(doubleFeedCollectionView)
        doubleFeedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(250)
            make.left.right.centerX.equalToSuperview()
        }
        lastView = doubleFeedCollectionView
        
        // grouped
        let titleLabel_3 = UILabel()
        titleLabel_3.text = "Group"
        titleLabel_3.textColor = .black
        scrollView.addSubview(titleLabel_3)
        titleLabel_3.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(40)
        }
        lastView = titleLabel_3
        
        scrollView.addSubview(groupCollectionView)
        groupCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lastView.snp.bottom)
            make.height.equalTo(250)
            make.left.right.centerX.equalToSuperview()
        }
        lastView = groupCollectionView
        
        
        lastView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
    
    func getNormalCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        //        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 60)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 20
        //        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 0
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.getDescription())
        collectionView.register(FlowLayoutCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader")
        collectionView.panGestureRecognizer.maximumNumberOfTouches = 1
        return collectionView
    }
    
    func getDoubleFlowCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 1
        collectionView.contentInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.getDescription())
        collectionView.register(FlowLayoutCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader")
        collectionView.panGestureRecognizer.maximumNumberOfTouches = 1
        return collectionView
    }
    
    func getDoubleFeedCollectionView() -> UICollectionView {
        let layout = DoubleFeedLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 2
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.getDescription())
        collectionView.register(FlowLayoutCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader")
        collectionView.panGestureRecognizer.maximumNumberOfTouches = 1
        return collectionView
    }
    
    func getGroupCollectionView() -> UICollectionView {
        let layout = CollectionViewGroupedLayout()
        layout.itemSize = CGSize(width: 100, height: 60)
        layout.sectionInset = .init(top: 30, left: 0, bottom: 30, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 3
        collectionView.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.getDescription())
        collectionView.register(FlowLayoutCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader")
        collectionView.panGestureRecognizer.maximumNumberOfTouches = 1
        return collectionView
    }
}

extension FlowLayoutViewController: UICollectionViewDelegate {
    
}

extension FlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.object(at: collectionView.tag)?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.object(at: collectionView.tag)?.object(at: section)?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowLayoutCell.getDescription(), for: indexPath)
        if let flowLayoutCell = cell as? FlowLayoutCell {
            flowLayoutCell.label.text = data.object(at: collectionView.tag)?.object(at: indexPath.section)?.object(at: indexPath.item)
        }
        cell.backgroundColor = cellColors[(indexPath.row % 3)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard collectionView.tag == 3 else {
//            return UICollectionReusableView()
//        }
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "elementKindSectionHeader", for: indexPath)
        if let cell = header as? FlowLayoutCell {
            cell.label.text = data.object(at: collectionView.tag)?.object(at: indexPath.section)?.object(at: indexPath.item)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard collectionView.tag == 3 else {
            return .zero
        }
        return CGSize(width: 200, height: 60)
    }
}

extension FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: (UIScreen.main.bounds.width - 44) / 2, height: cellHeights[(indexPath.row % 5)])
        } else if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.itemSize
        } else {
            return .zero
        }
    }
}

class FlowLayoutCell: UICollectionViewCell {
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        bgView.layer.cornerRadius = 14.0
//        contentView.clipsToBounds = true
//        bgView.backgroundColor = .systemRed
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
