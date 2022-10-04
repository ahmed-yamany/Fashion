//
//  HomeCollectionReusableView.swift
//  Fashion
//
//  Created by Ahmed Yamany on 25/09/2022.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
    static let identifier = "HomeCollectionReusableView"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewAll.setTitle(LocalizedStrings.viewAll, for: .normal)
    }
    
    func setup(with name: String){
        self.nameLabel.text = name
    }
    
}
