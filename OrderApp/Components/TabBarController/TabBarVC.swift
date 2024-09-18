//
//  TabBarVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 16/09/2024.
//

import UIKit

class TabBarVC: UITabBarController {
    
//    var orderTabItem: UITabBarItem!
//    let vm = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllersWithNavigation()
        customizeTabBarAppearance()
//        addOservation()
        
    }
    
    
//    func addOservation() {
//        NotificationCenter.default.addObserver(self, selector: #selector(updateBadge), name: orderUpdateNotificatoin, object: nil)
//    }
//    
//    @objc func updateBadge() {
//        // Safely updating the badge value
//        let savedOrderCount = vm.getSavedOrderCount()
//        print(savedOrderCount)
//        orderTabItem.badgeValue = savedOrderCount > 0 ? "\(savedOrderCount)" : nil
//        
//    }
    
    func setupViewControllersWithNavigation() {
        
        let categoryVC = CategoriesVC()
        categoryVC.tabBarItem.title = "Menu"
        let OrderVC = OrderVC()
        OrderVC.tabBarItem.title = "Order"
        
        
        let firstNavController = UINavigationController(rootViewController: categoryVC)
        let secondNavController = UINavigationController(rootViewController: OrderVC)
        
        firstNavController.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "list.bullet"), tag: 0)
        secondNavController.tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "bag"), tag: 1)
        
        
        self.viewControllers = [firstNavController, secondNavController]
    }

    
    func customizeTabBarAppearance() {
    
        tabBar.backgroundColor = UIColor.OACloudWhite
        tabBar.tintColor = UIColor.OAMidnightBlue
        tabBar.unselectedItemTintColor = UIColor.secondaryLabel.withAlphaComponent(0.3)
        tabBar.isTranslucent = false
     
        tabBar.layer.cornerRadius = 15
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.masksToBounds = false
    }
}
