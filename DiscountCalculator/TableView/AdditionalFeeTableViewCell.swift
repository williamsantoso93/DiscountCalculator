//
//  AdditionalFeeTableViewCell.swift
//  DiscountCalculator
//
//  Created by William Santoso on 22/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class AdditionalFeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    let pickerAdditionalFeeData: [String] = ["Discount", "Tax", "Delivery Fee" ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        typeTextField.inputView = picker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AdditionalFeeTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerAdditionalFeeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerAdditionalFeeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = pickerAdditionalFeeData[row]
    }
}
