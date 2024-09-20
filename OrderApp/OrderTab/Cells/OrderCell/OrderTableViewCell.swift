//
//  OrderTableViewCell.swift
//  OrderApp
//
//  Created by Abd Elrahman Atallah on 18/09/2024.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String, price: String, image: UIImage) {
        self.nameLabel.text = name
        self.priceLabel.text = price
        self.cellImageView.image = image
    }
}
