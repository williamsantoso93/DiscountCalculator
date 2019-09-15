//
//  ListReceiptTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 13/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ListReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var receiptTitleLabel: UILabel!
    @IBOutlet weak var receiptDateLabel: UILabel!
    @IBOutlet weak var receiptTotalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
