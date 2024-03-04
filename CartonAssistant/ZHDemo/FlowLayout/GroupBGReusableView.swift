//
//  GroupBGReusableView.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/3/4.
//

import UIKit

class GroupBGReusableView: UICollectionReusableView {
    
    private lazy var bgView = createBGView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createBGView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }
}
