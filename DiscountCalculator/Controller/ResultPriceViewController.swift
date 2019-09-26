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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    var receipt = Receipt()
    var peoplesTotalPrice: [People] = []
    var pricesAfterDiscountTaxDeliveryFee: [Double] = []
    var priceAfterDiscountPerPerson = Double()
    var indexOf = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        collectionView.register(UINib.init(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        // Do any additional setup after loading the view.
        titleLabel.text = receipt.title
        receipt.totalPrice = countTotalPrice(receipt: receipt)
        
//        let totalPricePlusAdditonalPricesString = String(format: "%.0f", countTotalPricePlusAdditonalPrices(receipt: receipt).formattedWithSeparator)
        
        let totalPricePlusAdditonalPricesString = Int(countTotalPricePlusAdditonalPrices(receipt: receipt)).formattedWithSeparator
        totalPriceLabel.text = "Rp. \(totalPricePlusAdditonalPricesString)"
        
        dateLabel.text = dateToString(date: receipt.date)
        paidByLabel.text = "Paid by : \(receipt.paidBy)"
        
        pricesAfterDiscountTaxDeliveryFee = countDiscount(receipt: receipt)
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        //        performSegue(withIdentifier: "Detail", sender: self)
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let controller = segue.destination as! DetailResultViewController
            controller.receipt = self.receipt
            controller.indexOf = self.indexOf
            controller.priceAfterDiscountPerPerson = priceAfterDiscountPerPerson
        }
    }
    
    func countTotalPricePlusAdditonalPrices(receipt: Receipt) -> Double {
        var totalPrice: Double = 0
        for people in receipt.peoples {
            totalPrice += people.price
        }
        
        let discount: Double = getFee(type: "Discount", receipt: receipt)
        let tax: Double = getFee(type: "Tax", receipt: receipt)
        let deliveryFee: Double = getFee(type: "Delivery Fee", receipt: receipt)
        
        totalPrice = totalPrice - discount + tax + deliveryFee
        
        return totalPrice
    }
    
    func countTotalPrice(receipt: Receipt) -> Double {
        var totalPrice: Double = 0
        for people in receipt.peoples {
            totalPrice += people.price
        }
        
        return totalPrice
    }
    
    func countDiscount(receipt: Receipt) -> [Double] {
        let totalPrice: Double = receipt.totalPrice
        
        let discount: Double = getFee(type: "Discount", receipt: receipt)
        let tax: Double = getFee(type: "Tax", receipt: receipt)
        let deliveryFee: Double = getFee(type: "Delivery Fee", receipt: receipt)
        
        print("\(totalPrice) \(discount) \(tax) \(deliveryFee) ")
        
        var priceDeliveryFeePerPerson = Double()
        
        let percentDiscount = discount / totalPrice
        
        let percentTax = tax / totalPrice
        
        priceDeliveryFeePerPerson = deliveryFee / Double(receipt.peoples.count)
        
        var pricesAfterDiscountTaxDeliveryFee: [Double] = []
        
        for people in receipt.peoples {
            let price = people.price
            let priceDiscount = price * percentDiscount
            let priceAfterDiscount = price - priceDiscount
            
            let priceTax = price * percentTax
            let priceAfterDiscountTax = priceAfterDiscount + priceTax
            
            let priceAfterDiscountTaxDeliveryFee = priceAfterDiscountTax + priceDeliveryFeePerPerson
            
            //            pricesDiscount[index] = priceDiscount
            //            pricesTax[index] = priceTax
            //            pricesAfterDiscount[index] = priceAfterDiscount
            pricesAfterDiscountTaxDeliveryFee.append(priceAfterDiscountTaxDeliveryFee)
        }
        
        return pricesAfterDiscountTaxDeliveryFee
    }
}

extension ResultPriceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pricesAfterDiscountTaxDeliveryFee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
        let priceText: String = String(format: "%.0f", pricesAfterDiscountTaxDeliveryFee[indexPath.row].formattedWithSeparator)
        
        cell.nameLabel.text = receipt.peoples[indexPath.row].name
        cell.priceLabel.text = "Rp. \(priceText)"
        cell.delegate = self
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

extension ResultPriceViewController: ResultCollectionViewCellDelegate {
    func moreActionCollection() {
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

extension ResultPriceViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receipt.peoples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
//        let priceText: String = String(format: "%.0f", pricesAfterDiscountTaxDeliveryFee[indexPath.row])
        let priceText = Int(pricesAfterDiscountTaxDeliveryFee[indexPath.row]).formattedWithSeparator
        
        cell.nameLabel.text = receipt.peoples[indexPath.row].name
        cell.priceLabel.text = "Rp. \(priceText)"
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexOf = indexPath.row
        priceAfterDiscountPerPerson = pricesAfterDiscountTaxDeliveryFee[indexPath.row]
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
