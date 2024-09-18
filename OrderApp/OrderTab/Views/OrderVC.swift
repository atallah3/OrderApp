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
    
    //MARK: - Functions
    private func configureViewController() {
        title = "Order"
        view.addGradientBackgroundColor(with: UIColor.lightToOrangeGradient)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TableView Extension
extension OrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return vm.getMenuItemsCount()
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as? OrderTableViewCell
        else {
            return UITableViewCell()
        }
        vm.configureOrderCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
}
