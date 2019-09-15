//
//  InputDataTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 07/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class InputDataTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameTexfField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameTexfField.delegate = true as? UITextFieldDelegate
        self.priceTextField.delegate = true as? UITextFieldDelegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


//extension InputDataViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
