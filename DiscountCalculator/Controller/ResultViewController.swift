//
//  ResultViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 08/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = []
    var allPrices: [Double] = []
    var pricesAfterDiscount: [Double] = []
    var pricesAfterDiscountOngkirPajak: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneButtonDidTap(_ sender: Any) { self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ResultTableViewCell
        cell.namePriceLabel.text = """
        Nama :
        \(names[indexPath.row])
        Harga :
        \(allPrices[indexPath.row])
        Harga setelah Discount :
        \(pricesAfterDiscount[indexPath.row])
        Harga setelah Discount + Pajak :
        \(pricesAfterDiscountOngkirPajak[indexPath.row])
        """
        return cell
    }
    
    
}
