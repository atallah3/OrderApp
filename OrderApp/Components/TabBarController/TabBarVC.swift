//
//  TabBarVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 16/09/2024.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllersWithNavigation()
        customizeTabBarAppearance()
    }
    

    func setupViewControllersWithNavigation() {
        
        let categoryVC = CategoryTableViewController()
        let OrderVC = OrderTableViewController()

        let firstNavController = UINavigationController(rootViewController: categoryVC)
        let secondNavController = UINavigationController(rootViewController: OrderVC)
        
        firstNavController.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "list.bullet"), tag: 0)
        secondNavController.tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "bag"), tag: 1)
        
        
        self.viewControllers = [firstNavController, secondNavController]
    }

    
    func customizeTabBarAppearance() {

        self.tabBar.tintColor = .systemBlue
        self.tabBar.barTintColor = .white
        
//        tabBar.backgroundColor = .white
//        tabBar.tintColor = UIColor(named: "p300")
//        tabBar.unselectedItemTintColor = UIColor(named: "g200")
//        tabBar.isTranslucent = false
//        
//        tabBar.layer.cornerRadius = 20
//        
//        tabBar.layer.shadowColor = UIColor.black.cgColor
//        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        tabBar.layer.shadowRadius = 10
//        tabBar.layer.shadowOpacity = 0.2
//        tabBar.layer.masksToBounds = false
    }
}
