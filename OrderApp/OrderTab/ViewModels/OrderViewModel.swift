//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

class OrderViewModel {
    
    var minutesToPrepare: Int = 0
    var image: UIImage?
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
    
    func configureOrderCell(image: UIImage, cell: OrderTableViewCell, indexPath: IndexPath) {
        let name = orders[indexPath.row].name
        let price = "\(orders[indexPath.row].price)$"
        cell.configureCell(name: name, price: price, image: image)
        
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
    
    func removeAllSavedData() {
        UserDefaultManager.shared.removeAll()
        self.orders.removeAll()
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
    
    func getImageUrl(indexPath: IndexPath) -> URL {
        let orderUrl = getOrderWith(indexPath: indexPath).imageURL
        return orderUrl
    }
    
    func goToConfirmationOrderScreen(view: UIViewController) {
        let OrderConfiramtionVC = OrderConfirmationVC(vm: OrderConfirmationViewModel(minutesToPrepare: minutesToPrepare))
        OrderConfiramtionVC.delegate = (view as! OrderConfirmationVCDelegate)
        view.showBottomSheet(viewController: OrderConfiramtionVC)
    }
    
    private func downloadImage(indexPath: IndexPath) {
        fetchImage(indexPath: indexPath) { image in
            guard let image else { return }
            self.image = image
        }
    }
    
    func fetchImage(indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        Task {
            do {
                let image = try await netwoekManager.fetchImage(from: getImageUrl(indexPath: indexPath))
                DispatchQueue.main.async {
                    self.image = image
                    completion(image)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
