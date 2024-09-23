//
//  SceneDelegate.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 21/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
    
        window?.rootViewController = TabBarVC()
        window?.makeKeyAndVisible()
    }
    
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return MenuHelper.shared.userActivity
    }
    
    func scene(_ scene: UIScene, restoreInteractionStateWith stateRestorationActivity: NSUserActivity) {
        if let restoredOrder = stateRestorationActivity.order {
            MenuHelper.shared.order = restoredOrder
        }
        
        guard
            let restorationController = StateRestorationController(userActivity: stateRestorationActivity),
            let tabBarController = window?.rootViewController as? UITabBarController,
            tabBarController.viewControllers?.count == 2,
            let categoriesVC = (tabBarController.viewControllers?[0] as? UINavigationController)?.topViewController as? CategoriesVC
        else {
            return
        }
                
        switch restorationController {
        case .categories:
            break
            
        case .order:
            tabBarController.selectedIndex = 1
            
        case .menu(category: let category):
            let menuVC = MenuVC(nibName: "MenuVC", vm: MenuViewModel(category: category))
            categoriesVC.navigationController?.pushViewController(menuVC, animated: false)
            
        case .menuItemDetail(let menuItem):
            let menuVC = MenuVC(nibName: "MenuVC", vm: MenuViewModel(category: menuItem.category))
            let menuDetailsVC = MenuDetailVC(nibName: "MenuDetailVC", vm: MenuDetailViewModel(menuItem: menuItem))
            
            categoriesVC.navigationController?.pushViewController(menuVC, animated: false)
            categoriesVC.navigationController?.pushViewController(menuDetailsVC, animated: false)
        }
    }
    
}


