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
    var people = People()
    var additonalPrices: [AdditionalFee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "DetailResultTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailResultTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
     self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        // Do any additional setup after loading the view.
        
        people = receipt.peoples[indexOf]
        
        titleLabel.text = receipt.title
        dateLabel.text = dateToString(date: receipt.date)
        paidByLabel.text = receipt.paidBy
        additonalPrices = receipt.additionalPrices
        
        nameLabel.text = people.name
        priceLabel.text = "\(people.price)"
        dateLabel2.text = dateToString(date: receipt.date)
        paidBy.text = receipt.paidBy
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (additonalPrices.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailResultTableViewCell", for: indexPath) as! DetailResultTableViewCell
        
        if indexPath.row == 0 {
            let priceText: String = String(format: "%.0f", people.price)
            
            cell.typeLabel.text = people.name
            cell.priceLabel.text = priceText
        } else {
            let priceText: String = String(format: "%.0f", additonalPrices[indexPath.row].price)
            
            cell.typeLabel.text = additonalPrices[indexPath.row].type
            cell.priceLabel.text = priceText
        }
        
        return cell
    }
    
    
}
