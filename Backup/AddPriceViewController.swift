//
//  AddPriceViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

protocol AddPriceViewControllerDelegate {
    func addValue(name:String, price:String)
}

class AddPriceViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    
    var delegate:AddPriceViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate.addValue(name: self.nameText.text!, price: self.priceText.text!)
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
