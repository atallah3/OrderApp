//
//  UIColor+Ext.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

extension UIColor {
    static let OACloudWhite = UIColor(named: "Cloud White") ?? .white
    static let OAMidnightBlue = UIColor(named: "Midnight Blue") ?? .blue
    static let OAMintGreen = UIColor(named: "Mint Green") ?? .green
    static let OASunsetOrange = UIColor(named: "Sunset Orange") ?? .orange
    
    static let lightToOrangeGradient = [UIColor.OACloudWhite, UIColor.OASunsetOrange]
}
