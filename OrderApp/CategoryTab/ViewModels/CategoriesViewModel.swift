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
    
    func getCategories() -> [String]? {
        categoris
    }
    
    func getCategoriesCount() -> Int {
        guard let categoris else { return 0 }
        return categoris.count
    }
}
