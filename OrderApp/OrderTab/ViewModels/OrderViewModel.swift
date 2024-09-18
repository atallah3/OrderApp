//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

class OrderViewModel {
    
    private var orders: [DeliverdOrder] = [] {
        didSet {
            NotificationCenter.default.post(name: orderUpdateNotificatoin , object: nil)
        }
    }
    
    func getSavedOrderCount() -> Int {
        getSavedOrders().count
    }
    
    func getOrderWith(indexPath: IndexPath) -> DeliverdOrder {
        orders[indexPath.row]
    }
    
    func configureOrderCell(cell: OrderTableViewCell, indexPath: IndexPath) {
        let name = orders[indexPath.row].name
        let price = "\(orders[indexPath.row].price)$"
        cell.configureCell(name: name, price: price)
    }
    
    func getSavedOrders() -> [DeliverdOrder] {
        self.orders = UserDefaultManager.shared.getSavedOrders()
        return orders
    }
    
    func removeAt(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8) {
            let orderName = self.getOrderWith(indexPath: indexPath).name
            UserDefaultManager.shared.removeOrder(named: orderName )
            self.orders.remove(at: indexPath.row)
        }
    }
}
