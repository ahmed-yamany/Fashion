//
//  HomeBannerSection.swift
//  Fashion
//
//  Created by Ahmed Yamany on 28/09/2022.
//


import UIKit

class HomeBannerSection: CollectionViewSection{
    let sectionGroupHeight = 150 as CGFloat
    
    var collectionView: UICollectionView
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(sectionGroupHeight))
       
        super.init(itemSize: itemSize, groupSize: groupSize, supplementarySize: nil)

     }
    override func cellForItemAt(indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = HomeBannerCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let cell = cell as? HomeBannerCollectionViewCell else{return UICollectionViewCell()}
        return cell
    }

    override func networkRequest(completion: (() -> ())?) async {
        self.updateItems(with: [1])
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        if let completion = completion{
            completion()
        }
    }

    
}
