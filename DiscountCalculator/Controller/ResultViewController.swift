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
    @IBOutlet weak var resultLabel: UILabel!
    
    var personQty: Int?
    var discount: Double?
    var names: [String] = []
    var prices: [Double] = []
    var ongkir = Double()
    var pajak = Double()
    
    var priceOngkirPerPerson = Double()
    var pricesDiscount: [Double] = []
    var pricesPajak: [Double] = []
    var pricesAfterDiscount: [Double] = []
    var pricesAfterDiscountPajakOngkir: [Double] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        //append array
        for _ in 1 ... (personQty ?? 1) {
            pricesDiscount.append(0)
            pricesPajak.append(0)
            pricesAfterDiscount.append(0)
            pricesAfterDiscountPajakOngkir.append(0)
        }
        
        countDiscount()
        
        
        var totalPrice: Double = 0
        for price in prices {
            totalPrice += price
        }
        
        let persenDiscount = ((discount ?? 0) / totalPrice) * 100
        
        let persenPajak = ((pajak) / totalPrice) * 100
        
        resultLabel.text = """
        Total Price = \(String(format: "%.0f", totalPrice))
        Discount = \(String(format: "%.0f", persenDiscount)) %
        Tax = \(String(format: "%.0f", persenPajak)) %
        """
    }
    
    func countDiscount() {
        var totalPrice: Double = 0
        for price in prices {
            totalPrice += price
        }
        
        let persenDiscount = (discount ?? 0) / totalPrice
        
        let persenPajak = (pajak) / totalPrice
        
        priceOngkirPerPerson = ongkir / Double(personQty ?? 1)
        
        
        for index in 0 ... ((personQty ?? 1) - 1) {
            let priceDiscount = prices[index] * persenDiscount
            let priceAfterDiscount = prices[index] - priceDiscount
            
            let pricePajak = prices[index] * persenPajak
            let priceAfterDiscountPajak = priceAfterDiscount + pricePajak
            
            let priceAfterDiscountPajakOngkir = priceAfterDiscountPajak + priceOngkirPerPerson
            
            pricesDiscount[index] = priceDiscount
            pricesPajak[index] = pricePajak
            pricesAfterDiscount[index] = priceAfterDiscount
            pricesAfterDiscountPajakOngkir[index] = priceAfterDiscountPajakOngkir
        }
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personQty ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ResultTableViewCell
        let price: String = String(format: "%.0f", prices[indexPath.row])
        let priceDiscount: String = String(format: "%.0f", pricesDiscount[indexPath.row])
        let pricePajak: String = String(format: "%.0f", pricesPajak[indexPath.row])
        let priceOngkirPerPersonText: String = String(format: "%.0f", priceOngkirPerPerson)
        let priceAfterDiscountPajakOngkir: String = String(format: "%.0f", pricesAfterDiscountPajakOngkir[indexPath.row])
        
        cell.namePriceLabel.text = """
        Name :
        \(names[indexPath.row])
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
