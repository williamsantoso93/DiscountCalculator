//
//  DetailResultViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 15/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class DetailResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var paidBy: UILabel!
    
    var receipt = Receipt() {
        didSet{
            DispatchQueue.main.async {
//                self.tableView.reloadData()
                super.updateViewConstraints()
                self.heightTableView?.constant = self.tableView.contentSize.height
            }
        }
    }
    
    var indexOf = Int()
    var priceAfterDiscountPerPerson = Double()
    var additonalPrices: [AdditionalFee] = []
    
    let titleSection = ["Detail", "Total"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "DetailResultTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailResultTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
//        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        // Do any additional setup after loading the view.
        
        nameLabel.text = receipt.peoples[indexOf].name
        let priceString = Int(priceAfterDiscountPerPerson).formattedWithSeparator
        priceLabel.text = "Rp. \(priceString)"
        
        dateLabel2.text = dateToString(date: receipt.date)
        paidBy.text = "Paid by : \(receipt.paidBy)"
        
        for detailPerPerson in countDetailsFullPerPerson(receipt: receipt) {
            let detail = detailPerPerson
            additonalPrices.append(detail)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightTableView?.constant = self.tableView.contentSize.height
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
    
    var shareText: String = "Hello World"
    
    @IBAction func shareButtonDidTap(_ sender: Any) {
        
        let priceText = Int(receipt.peoples[indexOf].priceAfterDiscount).formattedWithSeparator
        
        shareText = """
        Hi \(receipt.peoples[indexOf].name),
        You have bought \(receipt.title), Rp. \(priceText)
        Paid by : \(receipt.paidBy)
        Thank you
        """
        
        let activityController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
//                print("completed")
            } else {
//                print("cancled")
            }
        }
        present(activityController, animated: true) {
//            print("presented")
        }
    }
}


extension DetailResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleSection[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return additonalPrices.count - 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailResultTableViewCell", for: indexPath) as! DetailResultTableViewCell
        
        if indexPath.section == 0 {
            let additionalPrice = additonalPrices[indexPath.row]
            
            cell.typeLabel.text = additionalPrice.type
            let totalPriceString = Int(additionalPrice.price).formattedWithSeparator
            cell.priceLabel.text = "Rp. \(totalPriceString)"
        } else if indexPath.section == 1 {
            let additionalPrice = additonalPrices[4]
            
            cell.typeLabel.text = additionalPrice.type
            let totalPriceString = Int(additionalPrice.price).formattedWithSeparator
            cell.priceLabel.text = "Rp. \(totalPriceString)"
        }
        return cell
    }
}
