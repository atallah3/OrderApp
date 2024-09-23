//
//  MenuVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class MenuVC: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let vm: MenuViewModel
    
    //MARK: - Init
    init(nibName: String, vm: MenuViewModel) {
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
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.updateUserActivity()
    }
    //MARK: - Funcitons
    private func configureViewController() {
        title = vm.getCategory().capitalized
        view.addGradientBackgroundColor(with: UIColor.lightToOrangeGradient)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureMenuCell(cell: MenuTableViewCell, indexPath: IndexPath) {
        if let menuItem = vm.getMenuItem(indexPath: indexPath)  {
            cell.configerCell(name: menuItem.name, price: "\(menuItem.price)$")
        } else {
            self.showAlert(title: "Error loading Menu", message: "Please check your internet connection", buttonLabel: "Dismiss")
        }
    }
}

//MARK: - tableView extension
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.getMenuItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        configureMenuCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = vm.getMenuItem(indexPath: indexPath) else { return }
        print(item)
        vm.showMenuDetailScreen(view: self, menuItem: item)
    }
}
