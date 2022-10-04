//
//  CategoriesSection.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit


class HomeCategoriesSection: CollectionViewSection{
    // MARK: - Properties
    let categoryCellWidth = 120 as CGFloat
    
    var collectionView: UICollectionView
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(categoryCellWidth), heightDimension: .estimated(categoryCellWidth))
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
       
        super.init(itemSize: itemSize, groupSize: groupSize, supplementarySize: supplementarySize)
        self.name = LocalizedStrings.categories

     }
    override func sectionLayout() -> NSCollectionLayoutSection {
        let section = super.sectionLayout()
        let supplementaryItem = super.sectionSupplementaryLayout(elementKind: HomeCollectionReusableView.identifier, alignment: .top)
        if let supplementaryItem = supplementaryItem{
            section.boundarySupplementaryItems = [supplementaryItem]
        }
        return section
    }
    
    override func cellForItemAt(indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CategoriesCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let cell = cell as? CategoriesCollectionViewCell else{return UICollectionViewCell()}
        if let category = items[indexPath.row] as? Category{
            cell.setup(with: category)
        }
        return cell
    }
    override func viewForSupplementaryElementOfKind(for indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryIdentifier = HomeCollectionReusableView.identifier
        guard let view = self.collectionView.dequeueReusableSupplementaryView(ofKind: supplementaryIdentifier, withReuseIdentifier: supplementaryIdentifier, for: indexPath) as? HomeCollectionReusableView else{return UICollectionReusableView()}
        
        if let name = self.name{
            view.setup(with: name)
        }

        return view

    }

    override func networkRequest(completion: (() -> ())?) async {
        let categoriesRequest = CategoriesReaquest()
        categoriesRequest.feach { result in
            switch result{
            case .success(let value):
                guard let value = value, let status = value.status else{return}
                if status{
                    guard let categories = value.data?.categories else{return}
                    self.updateItems(with: categories)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    if let completion = completion{
                        completion()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
  
}
