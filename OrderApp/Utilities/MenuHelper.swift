//
//  MenuHelper.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 23/09/2024.
//

import Foundation

class MenuHelper {
    
    static let shared = MenuHelper()
    var order = Order()
    var userActivity = NSUserActivity(activityType: "com.example.OrderApp.order")
    
    private init () {}
    
    func updateUserActivity(with controller: StateRestorationController) {
        switch controller {
        case .menu(let category):
            userActivity.menuCategory = category
        case .menuItemDetail(let menuItem):
            userActivity.menuItem = menuItem
        case .order, .categories:
            break
        }
        
        userActivity.controllerIdentifier = controller.identifier
    }
}
