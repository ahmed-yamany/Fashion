//
//  HomeViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let nav = navigationController as? CoreNavigationController else{return}
        nav.addNotificationToRightBarButtonItems()
        nav.addCartToRightBarButtonItems()
        nav.addLogoCenterOfNavigationBar()
        
    }


}
