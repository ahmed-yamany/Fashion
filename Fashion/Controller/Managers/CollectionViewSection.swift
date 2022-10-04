//
//  CollectionViewSection.swift
//  Fashion
//
//  Created by Ahmed Yamany on 28/09/2022.
//

import UIKit

class CollectionViewSection: CollectionViewSectionDelegate{
    typealias Response = any Hashable
    var items: [Response] = []
    var name: String?
    


    // MARK: - Section Layout
    var itemSize: NSCollectionLayoutSize
    var groupSize: NSCollectionLayoutSize
    var supplementarySize: NSCollectionLayoutSize?
    
    init(itemSize: NSCollectionLayoutSize, groupSize: NSCollectionLayoutSize, supplementarySize: NSCollectionLayoutSize?){
        self.itemSize = itemSize
        self.groupSize = groupSize
        self.supplementarySize = supplementarySize
    }
    
    // MARK: - Section Layout
    func sectionItemLayout() -> NSCollectionLayoutItem{
        return NSCollectionLayoutItem(layoutSize: self.itemSize)
    }
    func sectionGroupLayout() -> NSCollectionLayoutGroup{
        let item = self.sectionItemLayout()
        return  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    }
    func sectionSupplementaryLayout(elementKind: String, alignment: NSRectAlignment) -> NSCollectionLayoutBoundarySupplementaryItem?{
        guard let supplementarySize = supplementarySize else{return nil}
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: elementKind, alignment: alignment)
        
    }
    func sectionLayout() -> NSCollectionLayoutSection{
        let group = self.sectionGroupLayout()
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func networkRequest(completion: (() -> ())?) async {}
    
    func cellForItemAt(indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    func viewForSupplementaryElementOfKind(for indexPath: IndexPath) -> UICollectionReusableView?{
        nil
    }
    
    
    // MARK: - Private Functions
    func updateItems(with items: [any Hashable]){
        self.items = items
    }
    func updateItemsAndReloadCollectionView(result: Products?){
       guard let value = result, let status = value.status else{return}
       if status{
           guard let products = value.data?.products else{return}
           self.updateItems(with: products)
       }
   }

    
}
