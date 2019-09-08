//
//  InputDataViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 06/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class InputDataViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableAndButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var personQty: Int?
    
    var names: [String] = []
    var pricesText: [String] = []
    var prices: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        //append array
        for index in 1 ... (personQty ?? 1) {
            names.append("No Name \(index)")
            pricesText.append("0")
            prices.append(0)
        }
        
        //move view when keyboard apprear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    var prevNextButtonOriginY = CGRect()
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
////            tableAndButtonView.frame.origin.y = -keyboardRect.height
//            tableView.frame.size = CGSize(height: -keyboardRect.height)
//            prevNextButtonOriginY = nextButton.frame
//            print("test")
//            print(prevNextButtonOriginY)
//            print(nextButton.frame.origin.y)
//            nextButton.frame.origin.y = -keyboardRect.height
//            print(keyboardRect.height)
//            print(nextButton.frame.origin.y)
            
        } else {
//            let statusBarHeight = UIApplication.shared.statusBarFrame.height
//            let navBarHeight = self.navigationController?.navigationBar.frame.height
//
//            tableAndButtonView.frame.origin.y = statusBarHeight + (navBarHeight ?? 0)
//            nextButton.frame = prevNextButtonOriginY
        }
    }

    
    @IBAction func nextButtonDidTap(_ sender: Any) {
        resignFirstResponder()
        
        //change pricesText to Double
//        let qty: Int = Int(personQty ?? 1) - 1
//        for index in 0 ... qty {
//            let price: Double = Double(pricesText[index]) ?? 0
//            prices.insert(price, at: index)
//        }
        view.endEditing(true)
        
        print("names")
        print(names)
        print("prices")
        print(pricesText)
        print(prices)
        performSegue(withIdentifier: "inputDiscount", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputDiscount" {
            let controller = segue.destination as! InputDiscountViewController
            controller.personQty = self.personQty
            
            controller.names = self.names
            controller.prices = self.prices
        }
    }
    
    @objc func labelAndTextFieldDidTap(sender: UITextField!) {
        sender.resignFirstResponder()
    }
}


extension InputDataViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personQty ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InputDataTableViewCell
        cell.label.text = "\(indexPath.row + 1)"
        cell.nameTexfField.delegate =  self
        cell.nameTexfField.tag = indexPath.row
        cell.nameTexfField.placeholder = "Nama"
        cell.nameTexfField.setBottomBorder()
        
        cell.priceTextField.delegate =  self
        cell.priceTextField.tag = indexPath.row
        cell.priceTextField.placeholder = "Jumlah"
        cell.priceTextField.setBottomBorder()
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.placeholder == "Nama" {
            let indexOf = textField.tag
            if (indexOf <= (names.count - 1)) {
                names.remove(at: indexOf)
            }
            names.insert(textField.text!, at: indexOf)
        } else if textField.placeholder == "Jumlah" {
            let indexOf = textField.tag
            if (indexOf <= (pricesText.count - 1)) {
                pricesText.remove(at: indexOf)
            }
            pricesText.insert(textField.text!, at: indexOf)
            
            let price: Double = Double(pricesText[indexOf]) ?? 0
            prices[indexOf] = price
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
