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
    var discount: Double?
    var ongkir = Double()
    var pajak = Double()
    var priceOngkirPerPerson = Double()
    var text: String = "Hello World"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonDidTap(_ sender: Any) {
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

extension ResultPriceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return debtsData.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
//        let data = debtsData[indexPath.row]
//        let price = data.price!
//        let priceDiscount: String = String(format: "%.0f", data.priceDiscount)
//        let pricePajak: String = String(format: "%.0f", data.pricePajak)
//        let priceOngkirPerPersonText: String = String(format: "%.0f", priceOngkirPerPerson)
//        let priceAfterDiscountPajakOngkir: String = String(format: "%.0f", data.priceAfterDiscountPajakOngkir)
        cell.nameLabel.text = "name"
        cell.priceLabel.text = "10000"
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
            self.present(activityController, animated: true) {
                print("presented")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("cancel")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
