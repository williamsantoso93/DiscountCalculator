//
//  InputDiscountViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 07/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class InputDiscountViewController: UIViewController {

    @IBOutlet weak var discountTextField: UITextField!
    
    var personQty: Int?
    var discount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.discountTextField.delegate = self
        discountTextField.setBottomBorder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextButtonDidTap(_ sender: Any) {
        let distString = discountTextField.text
        discount = Double(distString!) ?? 0
        if discount >= 0 {
            performSegue(withIdentifier: "inputData", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputData" {
            let controller = segue.destination as! InputDataViewController
            controller.personQty = self.personQty
            controller.discount =  self.discount
        }
    }
}

extension InputDiscountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
