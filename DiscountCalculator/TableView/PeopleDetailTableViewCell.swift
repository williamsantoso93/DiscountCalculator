//
//  PeopleDetailTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 06/10/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class PeopleDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
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
