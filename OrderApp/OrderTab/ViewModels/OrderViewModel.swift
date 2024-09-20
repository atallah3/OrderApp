//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

class OrderViewModel {
    
    var minutesToPrepare: Int = 0
//    var totalPrice = 0.0
    let netwoekManager = NetworkManager.shared
    
    private var orders: [DeliverdOrder] = [] {
        didSet {
            NotificationCenter.default.post(name: orderUpdateNotificatoin , object: nil)
        }
    }
    
    func getSavedOrderCount() -> Int {
        getSavedOrders().count
    }
    
    func getOrderWith(indexPath: IndexPath) -> DeliverdOrder {
        orders[indexPath.row]
    }
    
    func configureOrderCell(cell: OrderTableViewCell, indexPath: IndexPath) {
        let name = orders[indexPath.row].name
        let price = "\(orders[indexPath.row].price)$"
        cell.configureCell(name: name, price: price)
        
    }
    
    func getSavedOrders() -> [DeliverdOrder] {
        self.orders = UserDefaultManager.shared.getSavedOrders()
        return orders
    }
    
    func removeAt(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8) {
            let orderName = self.getOrderWith(indexPath: indexPath).name
            UserDefaultManager.shared.removeOrder(named: orderName )
            self.orders.remove(at: indexPath.row)
        }
    }
    
    func getTotalPrice() -> Double {
        orders.reduce(0) { $0 + $1.price }
    }
    
    func actionSheetConfiguration(view: UIViewController) {
        guard isValidOrder(view: view) else { return }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            self.uploadOrder(view: view)
        }
        view.showActionSheetWithDismissBtn(title: "Confirm Order", message: "You about to submit order with a total of \(getTotalPrice())$", action: submitAction)
    }
    
    func isValidOrder(view: UIViewController) -> Bool {
        if orders.isEmpty {
            view.showAlert(title: "You look so hungry 😋", message: "Add some items to your order", buttonLabel: "Ok")
            return false
        }
        return true
    }
    
    func uploadOrder(view: UIViewController) {
        Task {
            do {
                let minutesToPrepare = try await netwoekManager.submitOrder(forMenuIDs: getOrderIds())
                self.minutesToPrepare = minutesToPrepare
                DispatchQueue.main.async {
                    self.goToConfirmationOrderScreen(view: view)
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func getOrderIds() -> [Int] {
        var menuIds: [Int] = []
        for order in orders {
            menuIds.append(order.id)
        }
        return menuIds
    }
    
    func goToConfirmationOrderScreen(view: UIViewController) {
        let OrderConfiramtionVC = OrderConfirmationVC(nibName: "OrderConfirmationVC", bundle: nil)
        OrderConfiramtionVC.minutesToPrepare = minutesToPrepare
        view.present(OrderConfiramtionVC, animated: true)
    }
}
