//
//  Home2ViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 12/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class Home2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func addList(_ sender: Any) {
        performSegue(withIdentifier: "List", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailPriceSegue" {
//            let controller = segue.destination as! DebtsProcessViewController
//        }
    }
}
