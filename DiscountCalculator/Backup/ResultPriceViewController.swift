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
    var text: String = "Hello World"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paidByLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    var receipt = Receipt()
    var peoplesTotalPrice: [People] = []
    var pricesAfterDiscountTaxDeliveryFee: [Double] = []
    var indexOf = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let peoples = receipt.peoples
        let additionalFees = receipt.additionalPrices
        
        // Do any additional setup after loading the view.
        titleLabel.text = receipt.title
        let totalPrice: Double = countTotalPrice(peoples: peoples)
        let totalPriceString = String(format: "%.0f", totalPrice)
        totalPriceLabel.text = "Rp. \(totalPriceString)"
        dateLabel.text = dateToString(date: receipt.date)
        paidByLabel.text = "Paid by : \(receipt.paidBy)"
        
        pricesAfterDiscountTaxDeliveryFee = countDiscount(peoples: peoples, additionalFees: additionalFees)
    }

    @IBAction func doneButtonDidTap(_ sender: Any) {
//        performSegue(withIdentifier: "Detail", sender: self)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let controller = segue.destination as! DetailResultViewController
            controller.receipt = self.receipt
            controller.indexOf = self.indexOf
        }
    }
    
    func countTotalPrice(peoples: [People]) -> Double {
        var totalPrice: Double = 0
        for people in peoples {
            totalPrice += people.price
        }
        
        return totalPrice
    }
    
    func getFee(type: String, additionalFees: [AdditionalFee]) -> Double {
        for additionalFee in additionalFees {
            if type == additionalFee.type {
                return additionalFee.price
            }
        }
        return 0
    }
    
    func countDiscount(peoples: [People], additionalFees: [AdditionalFee]) -> [Double] {
        let totalPrice: Double = countTotalPrice(peoples: peoples)
        
        let discount: Double = getFee(type: "Discount", additionalFees: additionalFees)
        let tax: Double = getFee(type: "Tax", additionalFees: additionalFees)
        let deliveryFee: Double = getFee(type: "Delivery Fee", additionalFees: additionalFees)
        
        print("\(totalPrice) \(discount) \(tax) \(deliveryFee) ")
        
        var priceDeliveryFeePerPerson = Double()
        
        let persenDiscount = discount / totalPrice

        let persenPajak = tax / totalPrice

        priceDeliveryFeePerPerson = deliveryFee / Double(peoples.count)

        var pricesAfterDiscountTaxDeliveryFee: [Double] = []

        for people in peoples {
            let price = people.price
            let priceDiscount = price * persenDiscount
            let priceAfterDiscount = price - priceDiscount

            let priceTax = price * persenPajak
            let priceAfterDiscountTax = priceAfterDiscount + priceTax

            let priceAfterDiscountTaxDeliveryFee = priceAfterDiscountTax + priceDeliveryFeePerPerson

//            pricesDiscount[index] = priceDiscount
//            pricesPajak[index] = pricePajak
//            pricesAfterDiscount[index] = priceAfterDiscount
            pricesAfterDiscountTaxDeliveryFee.append(priceAfterDiscountTaxDeliveryFee)
        }
        
        return pricesAfterDiscountTaxDeliveryFee
    }
}

extension ResultPriceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return debtsData.count
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return receipt.peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
//        let data = debtsData[indexPath.row]
//        let price = data.price!
//        let priceDiscount: String = String(format: "%.0f", data.priceDiscount)
//        let pricePajak: String = String(format: "%.0f", data.pricePajak)
//        let priceOngkirPerPersonText: String = String(format: "%.0f", priceOngkirPerPerson)
//        let priceAfterDiscountPajakOngkir: String = String(format: "%.0f", data.priceAfterDiscountPajakOngkir)
        let priceText: String = String(format: "%.0f", pricesAfterDiscountTaxDeliveryFee[indexPath.row])
        
        cell.nameLabel.text = receipt.peoples[indexPath.row].name
        cell.priceLabel.text = "Rp. \(priceText)"
        cell.delegate = self
//        cell.accessoryType = .detailButton
//        cell.namePriceLabel.text = """
//        Name :
//        \(data.name ?? "Unknown")
//        Price :
//        \(price)
//        Price Discount :
//        - \(priceDiscount)
//        Price Tax :
//        \(pricePajak)
//        Price Delivery Fee :
//        \(priceOngkirPerPersonText)
//        Price after Discount + Tax + Delivery Fee :
//        \(priceAfterDiscountPajakOngkir)
//        """
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOf = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "Detail", sender: self)
    }
}


extension ResultPriceViewController: ResultTableViewCellDelegate {
    func moreAction() {
        print("test")
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mark as Done", style: .default, handler: { (_) in
            print("Mark as Done")
        }))
        
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (_) in
            let activityController = UIActivityViewController(activityItems: [self.text], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = self.view
            
            activityController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    print("completed")
                } else {
                    print("cancled")
                }
            }
            self.present(activityController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
