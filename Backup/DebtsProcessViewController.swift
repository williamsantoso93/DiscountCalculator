//
//  DebtsProcessViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit
protocol DebtsProcessViewControllerDelegate {
    func processDebts(deliveryFee:String?, discount:String?, tax:String?)
}
class DebtsProcessViewController: UIViewController {
    var delegate:DebtsProcessViewControllerDelegate?
    @IBOutlet weak var deliveryFee: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var tax: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func processAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.processDebts(deliveryFee: self.deliveryFee.text!, discount: self.discount.text!, tax: self.tax.text!)
        }
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
