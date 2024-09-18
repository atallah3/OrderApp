//
//  UIView+EXT.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func addGradientBackgroundColor(with colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = colors.map { $0.cgColor }
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        
       
        if let oldLayer = self.layer.sublayers?.first as? CAGradientLayer {
            self.layer.replaceSublayer(oldLayer, with: gradientLayer)
        } else {
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}

