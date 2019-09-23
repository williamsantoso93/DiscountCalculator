//
//  ResultTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 08/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

protocol ResultTableViewCellDelegate {
    func moreAction()
}

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var delegate:ResultTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.rounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func moreButtonDidTap(_ sender: Any) {
        delegate?.moreAction()
    }
}
