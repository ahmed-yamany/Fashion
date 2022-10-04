//
//  SearchResultSection.swift
//  Fashion
//
//  Created by Ahmed Yamany on 04/10/2022.
//

import UIKit

class SearchResultsSection: CollectionViewSection{
    var collectionView: UICollectionView
    init(collectionView: UICollectionView){
        self.collectionView = collectionView

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(220))
        super.init(itemSize: itemSize, groupSize: groupSize, supplementarySize: nil)
        
    }
    override func sectionGroupLayout() -> NSCollectionLayoutGroup {
        let item = super.sectionItemLayout()
        if #available(iOS 16.0, *) {
            return  NSCollectionLayoutGroup.horizontal(layoutSize: super.groupSize, repeatingSubitem: item, count: 2)
        } else {
            return NSCollectionLayoutGroup.horizontal(layoutSize: super.groupSize, subitem: item, count: 2)
        }
    }
    
    override func sectionLayout() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: self.sectionGroupLayout())
        
        return section
    }
    
    override func cellForItemAt(indexPath: IndexPath) -> UICollectionViewCell {
        let productIdetifier = HomeProductsCollectionViewCell.identifier
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: productIdetifier, for: indexPath) as? HomeProductsCollectionViewCell else{
            return UICollectionViewCell()
        }
        if let product = self.items[indexPath.row] as? Product{
            cell.setup(with: product)
        }
        
        return cell
    }
    
   
}
