//
//  NavigationController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import UIKit

class CoreNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = Constants.shared.tintColor
    }
    
    func addLogoCenterOfNavigationBar(){
        guard let visibleViewController = visibleViewController else{return}
        let logoImage = UIImage(named: "logo")
        let logoImageView = UIImageView(image: logoImage)
        visibleViewController.navigationItem.titleView = logoImageView
    }
    
    func addNotificationToRightBarButtonItems(){
        let notificationImage = UIImage(systemName: "bell")
        let notificatinBarButtonItem = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(self.notificatinBarButtonItemAction))
        
        self.addBarButtonItemToRightBarButtonItems(notificatinBarButtonItem)
    }
    
    func addCartToRightBarButtonItems(){
        let cartImage = UIImage(systemName: "cart.badge.plus")
        let cartBarButtonItem = UIBarButtonItem(image: cartImage, style: .plain, target: self, action: #selector(self.cartBarButtonItemAction))
        self.addBarButtonItemToRightBarButtonItems(cartBarButtonItem)
    }
    
    private func addBarButtonItemToRightBarButtonItems(_ item: UIBarButtonItem){
        guard let visibleViewController = visibleViewController else{return}
        guard let _ = visibleViewController.navigationItem.rightBarButtonItems else{
            visibleViewController.navigationItem.rightBarButtonItems = [item]
            return
        }
        visibleViewController.navigationItem.rightBarButtonItems?.append(item)
    }
    
    @objc func notificatinBarButtonItemAction(){
        print("notification bar button item pressed")
        pushViewController(FavouritesViewController(), animated: true)
    }
    
    @objc func cartBarButtonItemAction(){
        print("cart bar button item pressed")
    }
    
    
    
    



}
