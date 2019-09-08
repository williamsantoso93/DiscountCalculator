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
    }
    
    func countDiscount() {
        var totalPrice: Double = 0
        for price in prices {
            totalPrice += price
        }
        print("total")
        print(totalPrice)
        
        let persenDiscount = (discount ?? 0) / totalPrice
        print("persen diskon")
        print(persenDiscount)
        
        let persenPajak = (pajak) / totalPrice
        print("persen pajak")
        print(persenPajak)
        
        priceOngkirPerPerson = ongkir / Double(personQty ?? 1)
        print("ongkir per orang")
        print(priceOngkirPerPerson)
        
        
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
        
        print("price after diskon")
        print(pricesAfterDiscount)
        print("price after diskon pajak ongkir")
        print(pricesAfterDiscountPajakOngkir)
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
        cell.namePriceLabel.text = """
        Nama :
        \(names[indexPath.row])
        Harga :
        \(prices[indexPath.row])
        Harga Discount :
        - \(pricesDiscount[indexPath.row])
        Harga pajak :
        \(pricesPajak[indexPath.row])
        Harga Ongkir :
        \(priceOngkirPerPerson)
        Harga setelah Discount + Pajak + Ongkir :
        \(pricesAfterDiscountPajakOngkir[indexPath.row])
        """
        return cell
    }
    
    
}
