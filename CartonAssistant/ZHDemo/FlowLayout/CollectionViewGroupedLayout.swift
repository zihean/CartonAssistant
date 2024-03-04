//
//  CollectionViewGroupedLayout.swift
//  CartonAssistant
//
//  Created by ByteDance on 2024/3/1.
//

import UIKit

class CollectionViewGroupedLayout: UICollectionViewFlowLayout {
    
    static let decorationViewKind = "SectinoBGView"
    
    var bgMaring: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    private var headerAttributesList = [UICollectionViewLayoutAttributes]()
    private var cellAttributesMat = [[UICollectionViewLayoutAttributes]]()
    private var bgAttributesList = [UICollectionViewLayoutAttributes]()
    
    override init() {
        super.init()
        register(GroupBGReusableView.self, forDecorationViewOfKind: CollectionViewGroupedLayout.decorationViewKind)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        
        // reset
        headerAttributesList.removeAll()
        cellAttributesMat.removeAll()
        bgAttributesList.removeAll()
        
        guard let collectionView else {
            return
        }
        
        for section in 0..<collectionView.numberOfSections {
            let sectionIndexPath = IndexPath(item: 0, section: section)
            
            if let attributes = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: sectionIndexPath) {
                headerAttributesList.append(attributes)
            }
            
            var cellAttributesList = [UICollectionViewLayoutAttributes]()
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                if let attributes = layoutAttributesForItem(at: indexPath) {
                    cellAttributesList.append(attributes)
                }
            }
            cellAttributesMat.append(cellAttributesList)
            
            if let attributes = layoutAttributesForDecorationView(ofKind: CollectionViewGroupedLayout.decorationViewKind, at: sectionIndexPath) {
                bgAttributesList.append(attributes)
            }
        }
    }
    
    public override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView,
              collectionView.numberOfSections > 0,
              elementKind == CollectionViewGroupedLayout.decorationViewKind else {
            return nil
        }
        
        var bgRect = calculateSectionBoundingRectForCellsAndHeaders(for: indexPath.section)
        bgRect = bgRect.inset(by: -bgMaring)
        
        let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: CollectionViewGroupedLayout.decorationViewKind, with: indexPath)
        attributes.frame = bgRect
        attributes.zIndex -= 1
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes = [UICollectionViewLayoutAttributes]()
        
        allAttributes.append(contentsOf: headerAttributesList)
        for list in cellAttributesMat {
            allAttributes.append(contentsOf: list)
        }
        allAttributes.append(contentsOf: bgAttributesList)
        
        return allAttributes
    }
}

private extension CollectionViewGroupedLayout {
    func calculateSectionBoundingRectForCells(for section: Int) -> CGRect {
        guard let itemCount = collectionView?.numberOfItems(inSection: section),
              itemCount > 0
        else {
            assertionFailure()
            return .zero
        }
        
        var boundingRect: CGRect = cellAttributesMat.object(at: section)?.first?.frame ?? CGRect.zero
        for item in 1..<itemCount {
            guard let layoutAttributes = cellAttributesMat.object(at: section)?.object(at: item) else {
                assertionFailure("No layout attributes!")
                continue
            }
            boundingRect = CGRectUnion(boundingRect, layoutAttributes.frame)
        }
        
        return boundingRect
    }
    
    func calculateSectionBoundingRectForCellsAndHeaders(for section: Int) -> CGRect {
        var boundingRect = calculateSectionBoundingRectForCells(for: section)
        
        guard let headerAttributes = headerAttributesList.object(at: section) else {
            return boundingRect
        }
        
        boundingRect = boundingRect.union(headerAttributes.frame)
        
        return boundingRect
    }
}
