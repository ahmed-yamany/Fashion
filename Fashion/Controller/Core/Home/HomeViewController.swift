//
//  HomeViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - SubViews
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultsViewController())
        return searchController
    }()
        lazy var collectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
            collectionView.dataSource = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.collectionViewLayout = self.collectionViewLayout()
            let identifier = CategoriesCollectionViewCell.identifier
            collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)

            return collectionView
        }()
    
    // MARK: - Properties
    lazy var sections: [any HomeCollectionViewSectionDelegate] = {
        var sections: [any HomeCollectionViewSectionDelegate] = []
        sections.append(CategoriesSection())
        return sections
    }()

    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        self.setupNavigationItem()
        self.view.addSubview(collectionView)
        sections.forEach { section in
            section.networkRequest(collectionView, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Private Functions
    private func setupNavigationItem(){
        guard let navigationController = self.navigationController as? CoreNavigationController else{return}
        navigationController.setup(with: .notificationWithCart)
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { [ weak self]  sectionIndex, layoutEnvironment in
            let section = self?.getSection(at: sectionIndex)
            return section?.collectionViewLayout()
        }
        return layout
    }
    
    private func getSection(at index: Int) -> any HomeCollectionViewSectionDelegate{
        return self.sections[index]
    }
}
// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return sections.count
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         let section = getSection(at: section)
         return section.items.count
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let section = getSection(at: indexPath.section)
         return section.cellForItemAt(collectionView, indexPath: indexPath)
    }

}



