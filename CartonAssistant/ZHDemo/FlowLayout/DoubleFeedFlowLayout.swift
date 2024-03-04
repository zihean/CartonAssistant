//
//  DoubleFeedFlowLayout.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/2/29.
//

import UIKit

class DoubleFeedLayout: UICollectionViewLayout {
    
    var cellHeights: [CGFloat] = [100, 170, 190, 60, 100]
    
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var columnHeights = [CGFloat]()
    private var maxHeight: CGFloat = 0
    
    var lineSpacing: CGFloat = 10
    var interitemSpacing: CGFloat = 20
    var superInset: CGFloat = 12
    
    var avilableWidth: CGFloat {
        if let collectionView {
            var width = collectionView.frame.width
            width -= (2 * superInset)
            width -= CGFloat(columnHeights.count - 1) * interitemSpacing
            return width
        }
        return 0
    }
    
    override var collectionViewContentSize: CGSize {
        if let collectionView {
            return CGSize(width: collectionView.frame.width, height: maxHeight)
        }
        return .zero
    }
    
    override func prepare() {
        super.prepare()
        print("prepare")
        
        // reset
        layoutAttributes = [UICollectionViewLayoutAttributes]()
        columnHeights = [0 ,0]
        maxHeight = 0
        
        guard let collectionView else {
            return
        }
        
        let count = collectionView.numberOfItems(inSection: 0)
        for row in 0..<count {
            var targetColumn = 0
            var targetHeight: CGFloat = 0
            
            let cellWidth = avilableWidth / CGFloat(columnHeights.count)
            let cellHeight = cellHeights[row % cellHeights.count]
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: row, section: 0))
            
            targetColumn = 0
            targetHeight = maxHeight
            
            for index in stride(from: columnHeights.count - 1, through: 0, by: -1) {
                let columnHeight = columnHeights[index]
                if columnHeight <= targetHeight {
                    // 找到高度最低的列用于放下一个Cell
                    targetColumn = index
                    targetHeight = columnHeight
                } else {
                    // 更新最大高度，高度最高的那一列的高度需要赋值给collectionview的contentsize的高度
                    maxHeight = max(maxHeight, targetHeight)
                }
            }
            let x = CGFloat(targetColumn) * (cellWidth + interitemSpacing) + superInset
            let y = targetHeight + lineSpacing
            attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            layoutAttributes.append(attributes)
            
            let newColumnHeight = y + cellHeight
            maxHeight = max(maxHeight, newColumnHeight)
            // 记录所有cell的attributes
            columnHeights[targetColumn] = newColumnHeight
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}
