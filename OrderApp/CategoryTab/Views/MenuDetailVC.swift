//
//  MenuDetailVC.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 17/09/2024.
//

import UIKit

class MenuDetailVC: UIViewController {
    
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
        print()
    }
    
    //MARK: - Funcitons

}
