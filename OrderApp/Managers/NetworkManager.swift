//
//  NetworkManager.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    static let order = Order()
    
    private init() {}
    
    let baseURL = URL(string: "http://localhost:8080/")
    
    func fetchCategoris() async throws -> [String] {
        guard let categoriesURL = baseURL?.appending(path: "categories") else {
            throw NetworkErrors.categoriesNotFound
        }
        
        let (data, response) = try await URLSession.shared.data(from: categoriesURL)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkErrors.categoriesNotFound
        }
        
        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
        
        return categoriesResponse.categories
        
    }
    
    func fetchMenuItems(for category: String) async throws -> [MenuItem] {
        guard let baseMenuURL = baseURL?.appending(path: "menu") else {
            throw NetworkErrors.menuItemsNotFound
        }
        
        let components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true )
        guard var components else { return [] }
        components.queryItems = [URLQueryItem(name: "category", value: category)]
        guard let menuURL = components.url else { throw NetworkErrors.menuItemsNotFound }
        
        let (data, response) = try await URLSession.shared.data(from: menuURL)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkErrors.menuItemsNotFound
        }
        
        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)
        
        return menuResponse.items
    }
    
    typealias MinutesToPrepare = Int
    
    func submitOrder(forMenuIDs menuIDs: [Int]) async throws -> MinutesToPrepare {
        guard let baseOrderURL = baseURL?.appending(path: "order") else {
            throw NetworkErrors.orderRequestFailed
        }
        
        var request = URLRequest(url: baseOrderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let menuDict = ["menuIds": menuIDs]
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(menuDict)
        
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkErrors.orderRequestFailed
        }
        
        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)
        
        return orderResponse.prepTime
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkErrors.imageDataMissing
        }
        
        guard let image = UIImage (data: data) else {
            throw NetworkErrors.imageDataMissing
        }
        return image
    }
}

