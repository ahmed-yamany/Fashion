//
//  SearchResultsViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import UIKit

class SearchResultsViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = self.collectionViewLayout()
        
        let productIdetifier = HomeProductsCollectionViewCell.identifier
        collectionView.register(UINib(nibName: productIdetifier, bundle: nil), forCellWithReuseIdentifier: productIdetifier)
        
        return collectionView
    }()
    
    lazy var searchResultSection = SearchResultsSection(collectionView: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ConstantsColors.shared.systemBackgroud
        view.addSubview(collectionView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func collectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { [ weak self]  sectionIndex, layoutEnvironment in
            return self?.searchResultSection.sectionLayout()
        }
        return layout
    }

}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResultSection.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.searchResultSection.cellForItemAt(indexPath: indexPath)
    }
}

extension SearchResultsViewController{
    func networkRequest(text: String){
        SearchRequest(text: text).send { [weak self] result in
            switch result{
            case .success(let value):
                self?.searchResultSection.updateItemsAndReloadCollectionView(result: value)
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}
