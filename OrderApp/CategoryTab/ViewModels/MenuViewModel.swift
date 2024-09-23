//
//  MenuViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class MenuViewModel {
    
    private var category: String
    private var menuItems: [MenuItem]?
    private let networkManager = NetworkManager.shared
    
    init(category: String) {
        self.category = category
        fetchMenuItems()
    }
    
    func fetchMenuItems() {
        Task {
            let menuItems = try await networkManager.fetchMenuItems(for: category)
            self.menuItems = menuItems
        }
    }
    
    func getMenuItem(indexPath: IndexPath) -> MenuItem? {
        if let menuItems = menuItems {
           return menuItems[indexPath.row]
        }
        return nil
    }
    
    func getMenuItemsCount() -> Int {
        guard let menuItems else { return 0 }
        return menuItems.count
    }
    
    func getCategory() -> String{
        category
    }
    
    
    func showMenuDetailScreen(view: UIViewController, menuItem: MenuItem) {
        let menuDetailVC = MenuDetailVC(nibName: "MenuDetailVC", vm: MenuDetailViewModel(menuItem: menuItem))
        view.navigationController?.pushViewController(menuDetailVC, animated: true)
    }
    
    func updateUserActivity() {
        MenuHelper.shared.updateUserActivity(with: .menu(category: category))
    }
}
