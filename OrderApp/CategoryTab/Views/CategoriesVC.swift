//
//  CategoriesVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class CategoriesVC: UIViewController {

    //MARK: - @IBOutletS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var vm = CategoriesViewModel()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
//        vm.fetchCategoriesData()
    }
    
    //MARK: - Functions
    func configureViewController() {
        title = "Menu"
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TableView Extension
extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.getCategoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
        if let title = vm.getCategories()  {
            
            cell.configureCell(title: title[indexPath.row].capitalized)
        } else {
            self.showAlert(title: "Error loading Categories", message: "Please check your internet connection", buttonLabel: "Dismiss")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
