//
//  Extension.swift
//  DiscountCalculator
//
//  Created by William Santoso on 06/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
