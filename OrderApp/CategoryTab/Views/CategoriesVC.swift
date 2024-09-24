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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.updateUserActivity()
    }
    
    //MARK: - Functions
    func configureViewController() {
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addGradientBackgroundColor(with: UIColor.lightToOrangeGradient)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureCategoryCell(cell: CategoriesTableViewCell, indexPath: IndexPath) {
        if let title = vm.getCategory(indexPath: indexPath)  {
            cell.configureCell(title: title.capitalized)
        } else {
            self.showAlert(title: "Error loading Categories", message: "Please check your internet connection", buttonLabel: "Dismiss")
        }
    }
}

//MARK: - TableView Extension
extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.getCategoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
        configureCategoryCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let category = vm.getCategory(indexPath: indexPath) else { return }
        vm.showMenuScreen(view: self, category: category)
    }
}
