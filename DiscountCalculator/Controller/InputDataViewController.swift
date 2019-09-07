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
    var discount: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView.init(frame: .zero)
//        createLabelAndTextField()
        
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
    var prevNextButtonOriginY = CGFloat()
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
////            tableAndButtonView.frame.origin.y = -keyboardRect.height
//            tableView.frame.size = CGSize(height: -keyboardRect.height)
//            prevNextButtonOriginY = nextButton.frame.origin.y
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
//            nextButton.frame.origin.y = prevNextButtonOriginY
        }
    }

    
    //MARK:- manage label and text field
    func createLabelAndTextField() {
        for qty in 1...personQty! {
            let addTextField = UITextField()
            
            addTextField.setBottomBorder()
            
            addTextField.placeholder = "Jumlah"
            let y = 30 + (44 + 10) * (qty - 1)
            let width = scrollView.frame.width - 40
            print(y)
            addTextField.frame =  CGRect(x: 20, y: y, width: Int(width), height: 44)
            addTextField.font = .preferredFont(forTextStyle: .title1)
            addTextField.backgroundColor = .white
            
            
//            NSLayoutConstraint.activate([
//                addTextField.topAnchor.constraint(equalTo: confirmationInfoView.topAnchor),
//                addTextField.bottomAnchor.constraint(equalTo: confirmationInfoView.bottomAnchor),
//                addTextField.leadingAnchor.constraint(equalTo: confirmationInfoView.leadingAnchor),
//                addTextField.trailingAnchor.constraint(equalTo: confirmationInfoView.trailingAnchor)
//                ])
            
//            addButton.backgroundColor = randomColor()
//            
//            addButton.frame = randomCoor(backView: view)
//            addButton.layer.cornerRadius = addButton.frame.width / 2
//            
            addTextField.addTarget(self, action: #selector(labelAndTextFieldDidTap), for: .touchUpInside)
//
//            addButton.alpha = 0
            
            self.scrollView.addSubview(addTextField)
            let w  = scrollView.frame.width
            scrollView.frame = CGRect(x: 0, y: 0, width: Int(w), height: y + 100)
        }
        print(scrollView.frame.height)
    }
    
    
    
//    func incorrectAnimation() {
//        for view in self.tableView as [UIView] {
//            if let btn = view as? UIButton {
//                UIView.animate(withDuration: 0.2) {
//                    btn.frame = self.randomCoor(backView: self.view)
//                    btn.layer.cornerRadius = btn.frame.width / 2
//                    if btn.tag != 1 {
//                        btn.backgroundColor = self.randomColor()
//                    }
//                }
//            }
//        }
//        self.view.sendSubviewToBack(meButton)
//    }
    @IBAction func nextButtonDidTap(_ sender: Any) {
        
//        performSegue(withIdentifier: "result", sender: nil)
        for priceText in allCellsPriceText {
            allPrices.append(Double(priceText)!)
        }
        
        print(allPrices)
        
        var totalPrice: Double = 0
        for price in allPrices {
            totalPrice += price
        }

        print(totalPrice)
        
        let persenDiscount = (discount ?? 0)/totalPrice
        print(persenDiscount)
        
        
        for price in allPrices {
            let priceAfterDiscount: Double = price * (1 - persenDiscount)
            
            pricesAfterDiscount.append(priceAfterDiscount)
        }
        
        
        print(pricesAfterDiscount)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "result" {
//            let controller = segue.destination as! InputDiscountViewController
//            controller.personQty = self.personQty
//
//        }
    }
    
    @objc func labelAndTextFieldDidTap(sender: UITextField!) {
        sender.resignFirstResponder()
    }
    var allCellsPriceText = [String]()
    var allCellsNameText = [String]()
    
    
    var allPrices: [Double] = []
    var pricesAfterDiscount: [Double] = []
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
        
        allCellsNameText.append("No Name \(cell.nameTexfField.tag + 1)")
        allCellsPriceText.append("0")
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.placeholder == "Nama" {
            print("Nama")
            let indexOf = textField.tag
            if (indexOf <= (allCellsNameText.count - 1)) {
                allCellsNameText.remove(at: indexOf)
            }
            allCellsNameText.insert(textField.text!, at: indexOf)
            print(allCellsNameText)
        } else if textField.placeholder == "Jumlah" {
            print("jumlah")
            let indexOf = textField.tag
            if (indexOf <= (allCellsPriceText.count - 1)) {
                allCellsPriceText.remove(at: indexOf)
            }
            allCellsPriceText.insert(textField.text!, at: indexOf)
            print(allCellsPriceText)
        }
    }
}
