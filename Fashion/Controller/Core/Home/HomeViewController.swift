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
        
        let bannerIdentifier = HomeBannerCollectionViewCell.identifier
        collectionView.register(UINib(nibName: bannerIdentifier, bundle: nil), forCellWithReuseIdentifier: bannerIdentifier)
        
        let categoriesIdentifier = CategoriesCollectionViewCell.identifier
        collectionView.register(UINib(nibName: categoriesIdentifier, bundle: nil), forCellWithReuseIdentifier: categoriesIdentifier)
        
        let productIdetifier = HomeProductsCollectionViewCell.identifier
        collectionView.register(UINib(nibName: productIdetifier, bundle: nil), forCellWithReuseIdentifier: productIdetifier)
        
        let supplementaryIdentifier = HomeCollectionReusableView.identifier
        collectionView.register(UINib(nibName: supplementaryIdentifier, bundle: nil), forSupplementaryViewOfKind: supplementaryIdentifier, withReuseIdentifier: supplementaryIdentifier)
        
        collectionView.collectionViewLayout = self.collectionViewLayout()
        return collectionView
    }()
    
    // MARK: - Properties
    lazy var sections: [any CollectionViewSectionDelegate] = {
        var sections: [any CollectionViewSectionDelegate] = []
        sections.append(HomeBannerSection(collectionView: collectionView))
        sections.append(HomeCategoriesSection(collectionView: collectionView))
        sections.append(FeaturedSection(collectionView: collectionView))
        sections.append(BestSellingSection(collectionView: collectionView))
        sections.append(HomeBannerSection(collectionView: collectionView))
        sections.append(NewArivalSection(collectionView: collectionView))
        return sections
    }()

    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        self.setupNavigationItem()
        self.view.addSubview(collectionView)
        sections.forEach { section in
            Task{
                await section.networkRequest(completion: nil)
            }
        }
        searchController.searchResultsUpdater = self
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
            return section?.sectionLayout()
        }
        return layout
    }
    private func getSection(at index: Int) -> any CollectionViewSectionDelegate{
        return self.sections[index]
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = self.getSection(at: section)
        return section.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.getSection(at: indexPath.section)
        return section.cellForItemAt(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.getSection(at: indexPath.section)
        guard let supplementaryElement = section.viewForSupplementaryElementOfKind(for: indexPath) else{return UICollectionReusableView()}
        return supplementaryElement
    }
}

extension HomeViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text
        guard let query = query, let searchResultVC = searchController.searchResultsController as? SearchResultsViewController else{return}
        searchResultVC.networkRequest(text: query)
    }

}



