//
//  HomeCollectionViewSectionDelegate.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit

protocol HomeCollectionViewSectionDelegate{
    associatedtype Item
     var items: [Item] {get set}
     func collectionViewLayout() -> NSCollectionLayoutSection
    func networkRequest(_ collectionView: UICollectionView, completion: (() -> ())?)
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
