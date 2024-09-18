//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import Foundation

class OrderViewModel {
    private let order = Order()
    
    func getOrder() -> Order {
        order
    }
    
    func getMenuItemsCount() -> Int{
        order.menuItems.count
    }
    
    func getMenuItems(indexPath: IndexPath) -> MenuItem {
        return order.menuItems[indexPath.row]
    }
    
    func configureOrderCell(cell: OrderTableViewCell, indexPath: IndexPath) {
        let menuItem = getSavedOrders()!
        let name = menuItem[indexPath.row].name
        let price = "\(menuItem[indexPath.row].price)$"
        cell.configureCell(name: name, price: price)
    }
    
    func getSavedOrders() -> [DeliverdOrder]? {
        UserDefaultManager.shared.getSavedOrders()
    }
}
