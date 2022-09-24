//
//  CategoriesSection.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit

class CategoriesSection: HomeCollectionViewSectionDelegate{
    typealias Item = Category
    var items: [Item] = []
 
    init(){}
    func collectionViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
         return section
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CategoriesCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let cell = cell as? CategoriesCollectionViewCell else{return UICollectionViewCell()}
        let category = items[indexPath.row]
        cell.setup(with: category)
        
        return cell
    }

    func networkRequest(_ collectionView: UICollectionView, completion: (() -> ())?) {
        let categoriesRequest = CategoriesReaquest()
        categoriesRequest.feach { [weak self] result in
            switch result{
            case .success(let value):
                guard let value = value, let status = value.status else{return}
                if status{
                    guard let categories = value.data?.categories else{return}
                    self?.updateItems(with: categories)
                    collectionView.reloadData()
                    if let completion = completion{
                        completion()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateItems(with items: [Category]){
        self.items = items
    }
}
