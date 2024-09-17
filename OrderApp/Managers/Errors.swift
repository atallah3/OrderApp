//
//  Errors.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import Foundation

enum NetworkErrors: Error, LocalizedError {
    case categoriesNotFound
    case menuItemsNotFound
    case orderRequestFailed
}
