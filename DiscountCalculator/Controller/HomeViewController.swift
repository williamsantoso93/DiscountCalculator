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
    @IBOutlet var emptyDataView: UIView!
    @IBOutlet weak var splitButton: UIButton!
    
    
    
    var receipts: [Receipt] = [] {
        didSet {
            DispatchQueue.main.async {
//                self.receipts.sorted(by: { $0.compare($1) == .orderedDescending })
//                self.receipts.sort(by: <)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "ListReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ListReceiptTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        // Do any additional setup after loading the view.
        splitButton.rounded()
//        if #available(iOS 13.0, *) {
//            let navBarAppearance = UINavigationBarAppearance()
////            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//            navBarAppearance.backgroundColor = UIColor(red: 1, green: 0.75, blue: 0.18, alpha: 1)
//            UINavigationBar.appearance().barTintColor = UIColor(red: 1, green: 0.75, blue: 0.18, alpha: 1)
//
//            UINavigationBar.appearance().standardAppearance = navBarAppearance
//            UINavigationBar.appearance().compactAppearance = navBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        }
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(red: 1, green: 0.75, blue: 0.18, alpha: 1)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

            UINavigationBar.appearance().tintColor = UIColor(red: 1, green: 0.75, blue: 0.18, alpha: 1)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().barTintColor = UIColor(red: 1, green: 0.75, blue: 0.18, alpha: 1)
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    var a: Double = 0
    
    
    @IBAction func addList(_ sender: Any) {
        performSegue(withIdentifier: "CreateReceipt", sender: self)
//        let receipt = Receipt()
//
//        receipt.title = "hello"
//        receipt.date = Date()
//        receipt.paidBy = "me"
//        receipt.totalPrice = a
//        receipts.append(receipt)
//        a += 1
//        tableView.reloadData()
//        receipts.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func splitButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "CreateReceipt", sender: self)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.receipts.count == 0 {
            emptyDataView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            self.tableView.backgroundView = emptyDataView
        } else {
            self.tableView.backgroundView = nil
        }
        return self.receipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListReceiptTableViewCell", for: indexPath) as! ListReceiptTableViewCell
        cell.receiptTitleLabel.text = receipts[indexPath.row].title
        let dateText = dateToString(date: receipts[indexPath.row].date)
        cell.receiptDateLabel.text = dateText
        cell.receiptTotalPriceLabel.text = ("\(receipts[indexPath.row].totalPrice)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            receipts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
//            tableView.endUpdates()
        }
    }
}
