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
    
    func saveOrder(with order: DeliverdOrder) {
        var arrOfOrders: [DeliverdOrder]?
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(arrOfOrders)
            arrOfOrders?.append(order)
            UserDefaults.standard.set(data, forKey: UserDefaultManager.orderKey)
            
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func getSavedOrders() -> [DeliverdOrder]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultManager.orderKey) else {
            return nil
        }
        
        var arrOfOrders: [DeliverdOrder]?
        
        do {
            let decoder = JSONDecoder()
            let orders = try decoder.decode([DeliverdOrder].self, from: data)
            arrOfOrders = orders
        } catch {
            print("Error get data: \(error.localizedDescription)")
        }
        
        return arrOfOrders
    }
    
}
