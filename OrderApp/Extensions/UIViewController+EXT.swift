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
    
    func showActionSheetWithDismissBtn(title: String, message: String, action: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        alertController.addAction(action)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        self.present(alertController, animated: true)
    }
    
    func showBottomSheet(viewController: UIViewController) {
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 50
        }
        present(viewController, animated: true, completion: nil)
    }
}
