//
//  TabBarViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 22/09/2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Constants.shared.tintColor
        self.setUpViewController()
    }
    
    private func setUpViewController(){
        let homeVC = CoreNavigationController(rootViewController: HomeViewController())
        let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeVC.tabBarItem = homeTabBarItem
        
        let dealsVC = CoreNavigationController(rootViewController: DealsViewController())
        let dealsTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gift"), selectedImage: UIImage(systemName: "gift.fill"))
        dealsVC.tabBarItem = dealsTabBarItem
        
        let favouritesVC = CoreNavigationController(rootViewController: FavouritesViewController())
        let favouritesTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        favouritesVC.tabBarItem = favouritesTabBarItem
        
        let accountVC = CoreNavigationController(rootViewController: AccountViewController())
        let accountTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        accountVC.tabBarItem = accountTabBarItem
        
        self.viewControllers = [homeVC, dealsVC, favouritesVC, accountVC]

    }
    
}
