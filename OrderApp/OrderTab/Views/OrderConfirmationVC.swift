//
//  OrderConfirmationVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

class OrderConfirmationVC: UIViewController {
    
    //MARK: - Properties
    let vm: OrderConfirmationViewModel
    
    //MARK: - init
    init(vm: OrderConfirmationViewModel) {
        self.vm = vm
        super.init(nibName: "OrderConfirmationVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vm.minutesToPrepare)
    }
}
