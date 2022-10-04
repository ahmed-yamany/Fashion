//
//  NavigationController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import UIKit

class CoreNavigationController: UINavigationController {
    enum NaviggationControllerStyle{
        case notificationWithCart
        case notification
        case cart
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = ConstantsColors.shared.tintColor
    }
    
    func setup(with style: NaviggationControllerStyle){
        self.addLogoCenterOfNavigationBar()
        switch style{
        case .notificationWithCart:
            self.addNotificationToRightBarButtonItems()
            self.addCartToRightBarButtonItems()
        case .notification:
            self.addNotificationToRightBarButtonItems()
        case .cart:
            self.addCartToRightBarButtonItems()
        }
    }
    
    private func addLogoCenterOfNavigationBar(){
        guard let visibleViewController = visibleViewController else{return}
        let logoImage = UIImage(named: "logo")
        let logoImageView = UIImageView(image: logoImage)
        visibleViewController.navigationItem.titleView = logoImageView
    }
    
    private func addNotificationToRightBarButtonItems(){
        let notificationImage = UIImage(systemName: "bell")
        let notificatinBarButtonItem = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(self.notificatinBarButtonItemAction))
        self.addBarButtonItemToRightBarButtonItems(notificatinBarButtonItem)
    }
    
    private func addCartToRightBarButtonItems(){
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
//        pushViewController(FavouritesViewController(), animated: true)
    }
    
    @objc func cartBarButtonItemAction(){
        print("cart bar button item pressed")
    }
    
    
    
    



}
