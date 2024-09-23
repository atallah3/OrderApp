//
//  CategoriesViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class CategoriesViewModel {
    
    private var categoris: [String]?
    let networkManager = NetworkManager.shared
    
    init() {
        fetchCategoriesData()
    }
    
    func fetchCategoriesData() {
        Task {
            let categoris = try await networkManager.fetchCategoris()
            self.categoris = categoris
        }
    }
    
    func getCategory(indexPath: IndexPath) -> String? {
        if let categoris = categoris {
           return categoris[indexPath.row]
        }
        return nil
    }
    
    func getCategoriesCount() -> Int {
        guard let categoris else { return 0 }
        return categoris.count
    }
    
    func showMenuScreen(view: UIViewController, category: String) {
        let menuVC = MenuVC(nibName: "MenuVC", vm: MenuViewModel(category: category.lowercased()))
        view.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func updateUserActivity() {
        MenuHelper.shared.updateUserActivity(with: .categories)
    }
}
