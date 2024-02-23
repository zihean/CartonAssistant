//
//  MainTabButton.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/23.
//

import UIKit
import SnapKit

public class MainTabButton: UIButton {
    
    let item: MainTabItem
    
    private lazy var pinkSelectIndicator: UIView = makeIndicator()
    
    public override var isSelected: Bool {
        didSet {
            titleLabel?.alpha = isSelected ? 0.0 : 1.0
            pinkSelectIndicator.isHidden = !isSelected
        }
    }

    init(item: MainTabItem) {
        self.item = item
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainTabButton {
    struct Layout {
        static let imageViewSize: CGSize = CGSize(width: 24, height: 24)
    }
    
    func setupUI() {
        imageView?.contentMode = .center
        titleLabel?.textAlignment = .center
        setTitleColor(.lightGray, for: .selected)
        setTitleColor(.systemGray.withAlphaComponent(0.5), for: .normal)
        
        setImage(UIImage(named: item.defaultImageName), for: .normal)
        setImage(UIImage(named: item.selectedImageName), for: .selected)
        setTitle(item.title, for: .normal)
        
        setupIndicator()
    }
    
    func setupIndicator() {
        if let titleLabel, titleLabel.superview != nil {
            addSubview(pinkSelectIndicator)
            pinkSelectIndicator.snp.makeConstraints { (make) in
                make.center.equalTo(titleLabel)
                make.size.equalTo(CGSize(width: 22, height: 3))
            }
        }
    }
    
    func makeIndicator() -> UIView {
        let indicator = UIView()
        indicator.isHidden = true
        indicator.backgroundColor = .systemOrange
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = 2
        return indicator
    }
}
