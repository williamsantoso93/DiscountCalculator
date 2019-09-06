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
        // Do any additional setup after loading the view.
        textField.setBottomBorder()
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        personQty = Int(textField?.text ?? "0") ?? 0
        print(personQty)
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
