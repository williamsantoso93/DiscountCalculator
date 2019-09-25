//
//  DetailResultViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 15/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class DetailResultViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paidByLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var paidBy: UILabel!
    
    var receipt = Receipt()
    var indexOf = Int()
    var priceAfterDiscountPerPerson = Double()
    var additonalPrices: [AdditionalFee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "DetailResultTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailResultTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
     self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        // Do any additional setup after loading the view.
        
//        people = receipt.peoples[indexOf]
        
        titleLabel.text = receipt.title
        dateLabel.text = dateToString(date: receipt.date)
//        paidByLabel.text = receipt.paidBy
//        additonalPrices = receipt.additionalPrices
        
        nameLabel.text = receipt.peoples[indexOf].name
        let priceString = String(format: "%.0f", priceAfterDiscountPerPerson)
        priceLabel.text = "Rp. \(priceString)"
        
        dateLabel2.text = dateToString(date: receipt.date)
        paidByLabel.text = "Paid by : \(receipt.paidBy)"
        
        for detailPerPerson in countDetailsFullPerPerson(receipt: receipt) {
            let detail = detailPerPerson
            additonalPrices.append(detail)
        }
    }
    
    func countDetailsFullPerPerson(receipt: Receipt) -> [AdditionalFee] {
        let totalPrice: Double = receipt.totalPrice
        
        let discount: Double = getFee(type: "Discount", receipt: receipt)
        let tax: Double = getFee(type: "Tax", receipt: receipt)
        let deliveryFee: Double = getFee(type: "Delivery Fee", receipt: receipt)
        
        let priceDeliveryFeePerPerson = deliveryFee / Double(receipt.peoples.count)
        
        let percentDiscount = discount / totalPrice
        
        let percentTax = tax / totalPrice
        
        var detailsPerPerson: [AdditionalFee] = []
        
        let price = receipt.peoples[indexOf].price
        let priceDiscountPerPerson = price * percentDiscount
        let priceAfterDiscountPerPerson = price - priceDiscountPerPerson
        
        let priceTaxPerPerson = price * percentTax
        let priceAfterDiscountTax = priceAfterDiscountPerPerson + priceTaxPerPerson
        
        let priceAfterDiscountTaxDeliveryFee = priceAfterDiscountTax + priceDeliveryFeePerPerson
        
        let detailPerPerson = AdditionalFee()
        detailPerPerson.type = "Price"
        detailPerPerson.price = price
        detailsPerPerson.append(detailPerPerson)
        
        let detailPerPerson1 = AdditionalFee()
        detailPerPerson1.type = "Discount Per Person"
        detailPerPerson1.price = priceDiscountPerPerson
        detailsPerPerson.append(detailPerPerson1)
        
        let detailPerPerson2 = AdditionalFee()
        detailPerPerson2.type = "Tax Per Person"
        detailPerPerson2.price = priceTaxPerPerson
        detailsPerPerson.append(detailPerPerson2)
        
        let detailPerPerson3 = AdditionalFee()
        detailPerPerson3.type = "Delivery Fee Per Person"
        detailPerPerson3.price = priceDeliveryFeePerPerson
        detailsPerPerson.append(detailPerPerson3)
        
        let detailPerPerson4 = AdditionalFee()
        detailPerPerson4.type = "Total"
        detailPerPerson4.price = priceAfterDiscountTaxDeliveryFee
        detailsPerPerson.append(detailPerPerson4)
        
        return detailsPerPerson
    }
    
    var text: String = "Hello World"
    
    @IBAction func swipeDown(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func tapView(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func shareButtonDidTap(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
}


extension DetailResultViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ["Detail", "Total"]
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return additonalPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailResultTableViewCell", for: indexPath) as! DetailResultTableViewCell
        
//        if indexPath.row == 0 {
//            let priceText: String = String(format: "%.0f", people.price)
//
//            cell.typeLabel.text = people.name
//            cell.priceLabel.text = priceText
//        } else {
//            let priceText: String = String(format: "%.0f", additonalPrices[indexPath.row].price)
//
//            cell.typeLabel.text = additonalPrices[indexPath.row].type
//            cell.priceLabel.text = priceText
//        }
        
        let additionalPrice = additonalPrices[indexPath.row]
        
        cell.typeLabel.text = additionalPrice.type
        let totalPriceString = String(format: "%.0f", additionalPrice.price)
        cell.priceLabel.text = "Rp. \(totalPriceString)"
        
        return cell
    }
    
    
}
