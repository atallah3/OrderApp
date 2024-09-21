//
//  Int+EXT.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 20/09/2024.
//

import Foundation

extension Int {
    func toHoursAndMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours) hours \(minutes) minutes"
        } else if hours > 0 {
            return "\(hours) hours"
        } else {
            return "\(minutes) minutes"
        }
    }
}
