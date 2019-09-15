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
        textField.addDoneButtonOnKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.text = ""
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
}

extension InputPersonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
