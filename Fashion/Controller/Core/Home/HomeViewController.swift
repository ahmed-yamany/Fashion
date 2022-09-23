//
//  HomeViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
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
      
        collectionView.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Properties
    var categories: [Category] = []
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationItem()
        self.navigationItem.searchController = searchController
        self.view.addSubview(collectionView)
        categoriesNetworkRequest()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Private Functions
    private func setUpNavigationItem(){
        guard let navigationController = self.navigationController as? CoreNavigationController else{return}
        navigationController.addNotificationToRightBarButtonItems()
        navigationController.addCartToRightBarButtonItems()
        navigationController.addLogoCenterOfNavigationBar()
    }
 
    private func collectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            return self?.categoriesSectionLayout()
        }
        
        return layout
    }
    
    private func categoriesSectionLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
        
    }
    
}
// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return categories.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else{return CategoriesCollectionViewCell()}
        
        cell.setup(with: categories[indexPath.row])
        
        return cell
    }

}
// MARK: - Network Request
extension HomeViewController{
    func categoriesNetworkRequest(){
        let categoriesRequest = CategoriesReaquest()
        categoriesRequest.feach { result in
            switch result{
            case .success(let value):
                guard let value = value, let status = value.status else{return}
                if status{
                    guard let categories = value.data?.categories else{return}
                    self.categories = categories
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
