//
//  HomeCollectionViewSectionDelegate.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit

protocol CollectionViewSectionDelegate{
    associatedtype Response
    var items: [Response] {get set}
    var  name: String? {get set}

    // MARK: - Section Layout Properties
    var itemSize: NSCollectionLayoutSize {get set}
    var groupSize: NSCollectionLayoutSize {get set}
    var supplementarySize: NSCollectionLayoutSize? {get set}
    // MARK: - Section Layout
    func sectionItemLayout() -> NSCollectionLayoutItem
    func sectionGroupLayout() -> NSCollectionLayoutGroup
    func sectionSupplementaryLayout(elementKind: String, alignment: NSRectAlignment) -> NSCollectionLayoutBoundarySupplementaryItem?
    func sectionLayout() -> NSCollectionLayoutSection
    
    
    func networkRequest(completion: (() -> ())?) async
    func cellForItemAt(indexPath: IndexPath) -> UICollectionViewCell
    func viewForSupplementaryElementOfKind(for indexPath: IndexPath) -> UICollectionReusableView?
//
}
extension CollectionViewSectionDelegate{
    var supplementaryHeight: CGFloat {44}

}

