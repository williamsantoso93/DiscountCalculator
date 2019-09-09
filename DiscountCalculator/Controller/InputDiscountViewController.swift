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
    @IBOutlet weak var ongkirTextField: UITextField!
    @IBOutlet weak var pajakTextField: UITextField!
    
    var personQty: Int?
    var discount: Double = 0.0
    
    var names: [String] = []
    var prices: [Double] = []
    var ongkir = Double()
    var pajak = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.discountTextField.delegate = self
//        discountTextField.setBottomBorder()
    }
    
    @IBAction func nextButtonDidTap(_ sender: Any) {
        let distString = discountTextField.text
        discount = Double(distString!) ?? 0
        
        let ongkirString = ongkirTextField.text
        ongkir = Double(ongkirString!) ?? 0
        
        let pajakString = pajakTextField.text
        pajak = Double(pajakString!) ?? 0
        
        if (ongkir >= 0) && (pajak >= 0) && (discount >= 0) {
            performSegue(withIdentifier: "result", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            let controller = segue.destination as! ResultViewController
            controller.personQty = self.personQty
            controller.discount =  self.discount
            
            controller.names = self.names
            controller.prices = self.prices
            
            controller.ongkir = self.ongkir
            controller.pajak = self.pajak
        }
    }
}

extension InputDiscountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
