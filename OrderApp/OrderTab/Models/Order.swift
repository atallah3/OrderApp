//
//  Order.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = [] ) {
        self.menuItems = menuItems
    }
}
