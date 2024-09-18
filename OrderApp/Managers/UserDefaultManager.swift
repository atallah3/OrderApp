//
//  UserDefaultManager.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import Foundation

struct DeliverdOrder: Codable {
    let name: String
    let price: String
}

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    static let orderKey = "orders"
    
    private init() {}
    
    
    private func loadOrders() -> [DeliverdOrder] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultManager.orderKey) else { return [] }
        
        do {
            let decoder = JSONDecoder()
            let orders = try decoder.decode([DeliverdOrder].self, from: data)
            return orders
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveOrders(_ orders: [DeliverdOrder]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(orders)
            UserDefaults.standard.set(data, forKey: UserDefaultManager.orderKey)
            print("Order saved")
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
    
    func saveOrder(order: DeliverdOrder) {
        var orders = loadOrders()
        orders.append(order)
        saveOrders(orders)
    }
    
    func getSavedOrders() -> [DeliverdOrder] {
        return loadOrders()
    }
    
    func removeOrder(named orderName: String) {
        var orders = loadOrders()
        orders.removeAll { $0.name == orderName }
        saveOrders(orders)
    }
    
}
