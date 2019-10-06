//
//  ResultPriceViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class ResultPriceViewController: UIViewController {
    var shareText: String = "Hello World"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paidByLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var receipt = Receipt()
    var peoplesTotalPrice: [People] = []
    var pricesAfterDiscountTaxDeliveryFee: [Double] = []
    var priceAfterDiscountPerPerson = Double()
    var indexOf = Int()
    
    var delagete: HomeReceiveData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        // Do any additional setup after loading the view.
        titleLabel.text = receipt.title
        receipt.totalPrice = countTotalPrice(receipt: receipt)
        
        
        let totalPricePlusAdditonalPricesString = Int(countTotalPricePlusAdditonalPrices(receipt: receipt)).formattedWithSeparator
        totalPriceLabel.text = "Rp. \(totalPricePlusAdditonalPricesString)"
        
        dateLabel.text = dateToString(date: receipt.date)
        paidByLabel.text = "Paid by : \(receipt.paidBy)"
        
        pricesAfterDiscountTaxDeliveryFee = countDiscount(receipt: receipt)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        delagete?.pass(receipt: receipt)
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
            totalPrice += people.personTotalPrice
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
            totalPrice += people.personTotalPrice
        }
        
        return totalPrice
    }
    
    func countDiscount(receipt: Receipt) -> [Double] {
        let totalPrice: Double = receipt.totalPrice
        
        let discount: Double = getFee(type: "Discount", receipt: receipt)
        let tax: Double = getFee(type: "Tax", receipt: receipt)
        let deliveryFee: Double = getFee(type: "Delivery Fee", receipt: receipt)
        
        var priceDeliveryFeePerPerson = Double()
        
        let percentDiscount = discount / totalPrice
        
        let percentTax = tax / totalPrice
        
        priceDeliveryFeePerPerson = deliveryFee / Double(receipt.peoples.count)
        
        var pricesAfterDiscountTaxDeliveryFee: [Double] = []
        
        for people in receipt.peoples {
            let price = people.personTotalPrice
            let priceDiscount = price * percentDiscount
            let priceAfterDiscount = price - priceDiscount
            
            let priceTax = price * percentTax
            let priceAfterDiscountTax = priceAfterDiscount + priceTax
            
            let priceAfterDiscountTaxDeliveryFee = priceAfterDiscountTax + priceDeliveryFeePerPerson
            
            pricesAfterDiscountTaxDeliveryFee.append(priceAfterDiscountTaxDeliveryFee)
        }
        
        return pricesAfterDiscountTaxDeliveryFee
    }
}

extension ResultPriceViewController: ResultCollectionViewCellDelegate {
    func moreActionCollection(sender: UIButton) {
        let priceText = Int(receipt.peoples[sender.tag].priceAfterDiscount).formattedWithSeparator
        
        shareText = """
        Hi \(receipt.peoples[sender.tag].name),
        You have bought \(receipt.title), Rp. \(priceText)
        Paid by : \(receipt.paidBy)
        Thank you
        """
        
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mark as Done", style: .default, handler: { (_) in
//            print("Mark as Done")
        }))
        
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (_) in
            let activityController = UIActivityViewController(activityItems: [self.shareText], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = self.view
            
            activityController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
//                    print("completed")
                } else {
//                    print("cancled")
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
        
        receipt.peoples[indexPath.row].priceAfterDiscount = pricesAfterDiscountTaxDeliveryFee[indexPath.row]
        let priceText = Int(receipt.peoples[indexPath.row].priceAfterDiscount).formattedWithSeparator
        
        cell.nameLabel.text = receipt.peoples[indexPath.row].name
        cell.priceLabel.text = "Rp. \(priceText)"
        cell.moreButton.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexOf = indexPath.row
        priceAfterDiscountPerPerson = pricesAfterDiscountTaxDeliveryFee[indexPath.row]
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
