//
//  MenuDetailViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class MenuDetailViewModel {
    
    private var menuItem: MenuItem
    private var image: UIImage?
    private let networkManager = NetworkManager.shared
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    func getMenuItem() -> MenuItem {
        menuItem
    }
    
    func getDeliverdOrder() -> DeliverdOrder {
        DeliverdOrder(id: menuItem.id, name: menuItem.name, price: menuItem.price, imageURL: menuItem.imageURL)
    }
    
    func saveOrder() {
        UserDefaultManager.shared.saveOrder(order: getDeliverdOrder())
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        Task {
            do {
                let image = try await networkManager.fetchImage(from: menuItem.imageURL)
                DispatchQueue.main.async {
                    self.image = image
                    completion(image)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
