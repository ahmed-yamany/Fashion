//
//  HomeProductsCollectionViewCell.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import UIKit
class HomeProductsCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeProductsCollectionViewCell"
    var product: Product?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    
    var inFavorites: Bool = false{
        didSet{
            if inFavorites{
                favoriteButton.tintColor = UIColor(named: "pink")
            }else{
                favoriteButton.tintColor = UIColor.systemGray2
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadowAndConrnerRadius()
    }
    private func setupShadowAndConrnerRadius(){
        let cornerRadius = 15 as CGFloat
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        mainView.layer.shadowColor = UIColor.label.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.cornerRadius = cornerRadius

        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true

        layer.cornerRadius = cornerRadius
    }
    
    @IBAction func heartButtonPressed(_ sender: UIButton) {
        guard let product = self.product, let productId = product.id else{return}
        self.inFavorites.toggle()
        let favoriteRequest = AddOrDeleteFavoritesRequest(productId: productId)
        favoriteRequest.send { result in
            switch result{
            case .success(let value):
                guard let value = value, let status = value.status, status == true, let message = value.message else{return}
                print(message)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func setup(with product: Product){
        self.product = product
        if let image = product.image, let imageUrl = URL(string: image) {
            productImage.kf.setImage(with: imageUrl)
        }
        if let price = product.price{
            priceLabel.text = "EGP \(price)"
        }
        if let name = product.name{
            nameLabel.text = name
        }
        
        if let inFavorites = product.inFavorites {
            self.inFavorites = inFavorites
        }
                
    }

}
