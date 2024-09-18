//
//  MenuDetailViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class MenuDetailViewModel {
    
    private var menuItem: MenuItem
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    func getMenuItem() -> MenuItem {
        menuItem
    }
    
    func getDeliverdOrder() -> DeliverdOrder {
        DeliverdOrder(name: menuItem.name, price: "\(menuItem.price)")
    }
    
    func saveOrder() {
        UserDefaultManager.shared.saveOrder(order: getDeliverdOrder())
    }
}
