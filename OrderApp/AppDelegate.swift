//
//  AppDelegate.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 16/09/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = TabBarVC()
        window?.makeKeyAndVisible()
        
        return true
    }

}

