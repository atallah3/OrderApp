//
//  OrderConfirmationVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

protocol OrderConfirmationVCDelegate: AnyObject {
    func orderConfirmationDidDismiss()
}

class OrderConfirmationVC: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    weak var delegate: OrderConfirmationVCDelegate?
    
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
        configureViewController()
        confgureTimeLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.orderConfirmationDidDismiss()
    }
    
    //MARK: - Functions
    private func configureViewController() {
        title = "Order Confirmed"
        view.addGradientBackgroundColor(with: UIColor.orangeToLightGradient)
    }
    
    private func confgureTimeLabel() {
        timeLabel.text = "Your wating time is approximately \(vm.minutesToPrepare.toHoursAndMinutes())"
    }
}
