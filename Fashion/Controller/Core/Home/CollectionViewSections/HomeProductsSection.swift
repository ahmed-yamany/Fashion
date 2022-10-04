//
//  HomeProductsSection.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit

//
class HomeProductsSection: CollectionViewSection{
    
    // MARK: - Properties
    let groupWidth = 180 as CGFloat
    let groupHeight = 210 as CGFloat
    
    
    var collectionView: UICollectionView
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(groupWidth), heightDimension: .estimated(groupHeight))
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
       
        super.init(itemSize: itemSize, groupSize: groupSize, supplementarySize: supplementarySize)
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
        let identifier = HomeProductsCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let cell = cell as? HomeProductsCollectionViewCell else{return UICollectionViewCell()}
        if let product = items[indexPath.row] as? Product{
            cell.setup(with: product)
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

    override func networkRequest(completion: (() -> ())?) async {}
    
    override func updateItemsAndReloadCollectionView(result: Products?){
        guard let value = result, let status = value.status else{return}
        if status{
            guard let products = value.data?.products else{return}
            self.updateItems(with: products)
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
}

class FeaturedSection: HomeProductsSection{
    override init(collectionView: UICollectionView) {
         super.init(collectionView: collectionView)
        super.name = LocalizedStrings.featured
    }
    
    override func networkRequest(completion: (() -> ())?) async {
        FeaturedProductsReaquest().feach { [weak self] result in
            switch result{
            case .success(let value):
                self?.updateItemsAndReloadCollectionView(result: value)
                if let completion = completion{
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

class BestSellingSection: HomeProductsSection{
    override init(collectionView: UICollectionView) {
         super.init(collectionView: collectionView)
        super.name = LocalizedStrings.bestSelling
    }

    override func networkRequest(completion: (() -> ())?) async {
        BestSellingProductsReaquest().feach { [weak self] result in
            switch result{
            case .success(let value):
                self?.updateItemsAndReloadCollectionView(result: value)
                if let completion = completion{
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

class NewArivalSection: HomeProductsSection{
    override init(collectionView: UICollectionView) {
         super.init(collectionView: collectionView)
        super.name = LocalizedStrings.newArival
    }

    override func networkRequest(completion: (() -> ())?) async {
        NewArivalProductsRequest().feach { [weak self] result in
            switch result{
            case .success(let value):
                self?.updateItemsAndReloadCollectionView(result: value)
                if let completion = completion{
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

