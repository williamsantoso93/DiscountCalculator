//
//  OtherDataViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 08/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class OtherDataViewController: UIViewController {

    @IBOutlet weak var ongkirTextField: UITextField!
    @IBOutlet weak var pajakTextField: UITextField!
   
    var personQty: Int?
    var discount: Double?
    var names: [String] = []
    var prices: [Double] = []
    var ongkir = Double()
    var pajak = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextButtonDidTap(_ sender: Any) {
        let ongkirString = ongkirTextField.text
        ongkir = Double(ongkirString!) ?? 0
        
        let pajakString = pajakTextField.text
        pajak = Double(pajakString!) ?? 0
        
        if (ongkir >= 0) && (pajak >= 0) {
            performSegue(withIdentifier: "result", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            let controller = segue.destination as! ResultViewController
            controller.personQty = self.personQty
            controller.discount = self.discount ?? 0
            controller.names = self.names
            controller.prices = self.prices
            
            controller.ongkir = self.ongkir
            controller.pajak = self.pajak
        }
    }
}
