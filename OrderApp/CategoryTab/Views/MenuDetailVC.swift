//
//  MenuDetailVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class MenuDetailVC: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToOrder: UIButton!
    
    //MARK: - Properties
    let vm: MenuDetailViewModel
    
    //MARK: - Init
    init(nibName: String, vm: MenuDetailViewModel) {
        self.vm = vm
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getMenuDetailsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.updateUserActivity()
    }
    
    //MARK: - Funcitons
    private func configureViewController() {
        view.addGradientBackgroundColor(with: UIColor.orangeToLightGradient)
    }
    
    private func getMenuDetailsData() {
        let data = vm.getMenuItem()
        self.nameLabel.text = data.name
        self.detailTextLabel.text = data.detailText
        self.priceLabel.text = "\(data.price)$"
        downloadImage()
    }
    
    private func downloadImage() {
        vm.fetchImage { image in
            guard let image = image else { return }
            self.imageView.image = image
        }
    }
    
    //MARK: - @IBActions
    @IBAction func addOrderBtnTapped(_ sender: UIButton) {
        addToOrder.OAButtonAnimation()
        vm.saveOrder()
    }
}
