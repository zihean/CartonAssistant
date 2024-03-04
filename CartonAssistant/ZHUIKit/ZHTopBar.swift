//
//  ZHTopBar.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/29.
//

import UIKit

class ZHTopBar: UIView {
    
    typealias ItemConfig = ZHTopBarItemButton.ItemConfig

    private lazy var titleLabel = getTitleLabel()
    private lazy var leftItemBtn = ZHTopBarItemButton(true)
    private lazy var rightItemBtn = ZHTopBarItemButton(false)
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var leftItem: ItemConfig? = nil {
        didSet {
            leftItemBtn.update(with: leftItem)
        }
    }
    var rightItem: ItemConfig? = nil {
        didSet {
            rightItemBtn.update(with: rightItem)
        }
    }

    init(title: String,
         leftItem: ItemConfig,
         rightItem: ItemConfig? = nil) {
        super.init(frame: .zero)
        
        self.title = title
        self.leftItem = leftItem
        self.rightItem = rightItem
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(in superview: UIView) {
        superview.addSubview(self)
        snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(SafeAreaInsets.top + 60)
        }
    }
}

private extension ZHTopBar {
    func setupUI() {
        leftItemBtn.update(with: leftItem)
        leftItemBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemBtnTapped)))
        addSubview(leftItemBtn)
        leftItemBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        
        rightItemBtn.update(with: rightItem)
        rightItemBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemBtnTapped)))
        addSubview(rightItemBtn)
        rightItemBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.left.equalTo(leftItemBtn.snp.right).offset(10)
            make.right.equalTo(rightItemBtn.snp.left).offset(-10)
        }
        
        let splitView = UIView()
        splitView.backgroundColor = .systemGray
        addSubview(splitView)
        splitView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(onePixel)
        }
    }
    
    func getTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        return titleLabel
    }
    
    @objc func itemBtnTapped(_ recognizer: UITapGestureRecognizer) {
        guard let btn = recognizer.view as? ZHTopBarItemButton else {
            return
        }
        btn.config?.handler()
    }
}

class ZHTopBarItemButton: UIView {
    struct ItemConfig {
        let title: String
        let handler: ()->Void
    }
    
    private lazy var titleLabel = getTitleLabel()
    
    let forLeft: Bool
    
    var config: ItemConfig? = nil
    
    init(_ forLeft: Bool) {
        self.forLeft = forLeft
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with config: ItemConfig?) {
        self.config = config
        if let config {
            isHidden = false
            titleLabel.text = config.title
        } else {
            isHidden = true
        }
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            if forLeft {
                make.left.equalToSuperview()
            } else {
                make.right.equalToSuperview()
            }
        }
    }
    
    private func getTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = forLeft ? .left : .right
        return titleLabel
    }
}
