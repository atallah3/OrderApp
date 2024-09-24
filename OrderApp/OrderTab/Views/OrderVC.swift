//
//  OrderVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

class OrderVC: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var vm = OrderViewModel()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.updateUserActivity()
    }
    
    //MARK: - Functions
    private func configureViewController() {
        title = "Order"
        view.addGradientBackgroundColor(with: UIColor.lightToOrangeGradient)
        configureTopBarEditButton()
        configureTopBarSubmitButton()
    }
    
    private func configureTopBarEditButton() {
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .OAMidnightBlue
    }
    
    private func configureTopBarSubmitButton() {
        let submitButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitBtnTapped))
        submitButton.tintColor = .OAMidnightBlue
        navigationItem.setRightBarButton(submitButton, animated: false)
    }
    
    @objc func submitBtnTapped() {
        vm.actionSheetConfiguration(view: self)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
}

//MARK: - TableView Extension
extension OrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getSavedOrderCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as? OrderTableViewCell
        else { return UITableViewCell() }
        
        vm.fetchImage(indexPath: indexPath) { [weak self] image in
            guard let image = image, let self else { return }
            self.vm.configureOrderCell(image: image, cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.vm.removeAt(indexPath: indexPath)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

//MARK: - Order confirmation delegate
extension OrderVC: OrderConfirmationVCDelegate {
    func orderConfirmationDidDismiss() {
        vm.removeAllSavedData()
        tableView.reloadData()
    }
}
