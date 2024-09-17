//
//  UIViewController+EXT.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonLabel: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: buttonLabel ?? "Ok", style: .default))
        self.present(alertVC, animated: true)
    }
}
