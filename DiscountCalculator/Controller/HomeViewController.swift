//
//  Home2ViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 12/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var receipts: [Receipt] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "ListReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ListReceiptTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func addList(_ sender: Any) {
//        performSegue(withIdentifier: "CreateReceipt", sender: self)
        let receipt = Receipt()
        
        receipt.title = "hello"
        receipt.date = dateToString(date: Date())
        receipt.paidBy = "me"
        receipt.totalPrice = 1000000
        receipts.append(receipt)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailPriceSegue" {
//            let controller = segue.destination as! DebtsProcessViewController
//        }
    }
    let emptyLabel = UILabel()
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.receipts.count == 0 {
            emptyLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            emptyLabel.text = "No Data"
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
        } else {
            self.tableView.backgroundView = nil
        }
        return self.receipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListReceiptTableViewCell", for: indexPath) as! ListReceiptTableViewCell
        cell.receiptTitleLabel.text = receipts[indexPath.row].title
        cell.receiptDateLabel.text = receipts[indexPath.row].date
        cell.receiptTotalPriceLabel.text = ("\(receipts[indexPath.row].totalPrice)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            receipts.remove(at: indexPath.row)
        }
    }
}
