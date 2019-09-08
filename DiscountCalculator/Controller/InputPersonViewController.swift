//
//  ViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 06/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class InputPersonViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var personQty: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        // Do any additional setup after loading the view.
//        textField.setBottomBorder()
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        personQty = Int(textField?.text ?? "0") ?? 0
        if personQty > 0 {
            performSegue(withIdentifier: "inputData", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputData" {
            let controller = segue.destination as! InputDataViewController
            controller.personQty = self.personQty
        }
    }
    var amount = Double()
}

extension InputPersonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let digit = Double(string) {
            amount = amount * 10 + digit
        }
        if string == "" {
            amount = amount/10
        }
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        textField.text = formatter.string(from: NSNumber(value: amount))
        return false
    }
}
