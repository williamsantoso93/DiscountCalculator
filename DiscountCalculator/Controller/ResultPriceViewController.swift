//
//  ResultPriceViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ResultPriceViewController: UIViewController {
    
    var debtsData = [DebtData]()
    var discount: Double?
    var ongkir = Double()
    var pajak = Double()
    var priceOngkirPerPerson = Double()
    
    @IBOutlet weak var tableView: UITableView!
    
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

}

extension ResultPriceViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debtsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ResultTableViewCell
        let data = debtsData[indexPath.row]
        let price = data.price!
        let priceDiscount: String = String(format: "%.0f", data.priceDiscount)
        let pricePajak: String = String(format: "%.0f", data.pricePajak)
        let priceOngkirPerPersonText: String = String(format: "%.0f", priceOngkirPerPerson)
        let priceAfterDiscountPajakOngkir: String = String(format: "%.0f", data.priceAfterDiscountPajakOngkir)
        
        cell.namePriceLabel.text = """
        Name :
        \(data.name ?? "Unknown")
        Price :
        \(price)
        Price Discount :
        - \(priceDiscount)
        Price Tax :
        \(pricePajak)
        Price Delivery Fee :
        \(priceOngkirPerPersonText)
        Price after Discount + Tax + Delivery Fee :
        \(priceAfterDiscountPajakOngkir)
        """
        return cell
    }
    
    
}
