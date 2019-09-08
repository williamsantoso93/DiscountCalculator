//
//  ViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 06/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var personQty: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        // Do any additional setup after loading the view.
        textField.setBottomBorder()
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        personQty = Int(textField?.text ?? "0") ?? 0
        if personQty > 0 {
            performSegue(withIdentifier: "inputDiscount", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputDiscount" {
            let controller = segue.destination as! InputDiscountViewController
            controller.personQty = self.personQty
            
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
