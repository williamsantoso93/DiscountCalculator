//
//  AddDetailTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 02/10/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class AddDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
