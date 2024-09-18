//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import Foundation

class OrderViewModel {
    private var order = Order()
    
    func getOrder() -> Order {
        order
    }
    
    func getSavedOrderCount() -> Int {
        getSavedOrders().count
    }
    
    func getMenuItems(indexPath: IndexPath) -> MenuItem {
        return order.menuItems[indexPath.row]
    }
    
    func configureOrderCell(cell: OrderTableViewCell, indexPath: IndexPath) {
        let orders = getSavedOrders()
        let name = orders[indexPath.row].name
        let price = "\(orders[indexPath.row].price)$"
        cell.configureCell(name: name, price: price)
    }
    
    func getSavedOrders() -> [DeliverdOrder] {
        UserDefaultManager.shared.getSavedOrders()
    }
}
