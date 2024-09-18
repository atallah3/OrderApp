//
//  UIButton+EXT.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

extension UIButton {
    func OAButtonAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0,
                       usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
                       options: []) {
            self.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
