//
//  CategoriesCollectionViewCell.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import UIKit
import Kingfisher

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoriesCollectionViewCell"
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = categoryImage.frame.height/2
        categoryImage.clipsToBounds = true
    }
    
    func setup(with categoty: Category){
        if let imageString = categoty.image, let imageUrl = URL(string: imageString){
            categoryImage.kf.setImage(with: imageUrl)

        }
            
        guard let name = categoty.name else{return}
        categoryName.text = name
    }

}
