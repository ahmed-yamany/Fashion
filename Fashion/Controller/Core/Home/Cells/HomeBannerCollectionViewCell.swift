//
//  HomeBannerCollectionViewCell.swift
//  Fashion
//
//  Created by Ahmed Yamany on 28/09/2022.
//

import UIKit

class HomeBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeBannerCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        createGradiantLayer()
        
    }
    private func createGradiantLayer(){
       let gradiantLayer = CAGradientLayer()
       gradiantLayer.colors = [
           UIColor.clear.cgColor,
           UIColor.black.cgColor
       ]
       gradiantLayer.frame = bounds
       layer.addSublayer(gradiantLayer)
   }

}
