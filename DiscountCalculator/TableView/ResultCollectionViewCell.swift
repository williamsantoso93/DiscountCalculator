//
//  ResultCollectionViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 24/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

protocol ResultCollectionViewCellDelegate {
    func moreActionCollection()
}

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var delegate: ResultCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.rounded()
    }

    @IBAction func moreButtonDidTap(_ sender: Any) {
        delegate?.moreActionCollection()
    }
}
