//
//  DetailResultTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 15/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class DetailResultTableViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
