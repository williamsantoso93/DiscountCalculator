//
//  AddDetailViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 02/10/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    var items: [Item] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                super.updateViewConstraints()
                self.heightTableView?.constant = self.tableView.contentSize.height
                self.isEdit = false
            }
        }
    }
    
    var people = People()
    
    var delegate: CreateReceiptReceiveData?
    
    var isEdit: Bool?
    var editedPeople = People()
    var indexOf = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: "AddDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AddDetailTableViewCell")
        // Do any additional setup after loading the view.
        
        nameTextField.addDoneButtonOnKeyboard()
        nameTextField.setBottomBorder()
        
        hideKeyboardWhenTappedAround()
        if isEdit ?? false {
            people = editedPeople
            items = editedPeople.items
            nameTextField.text = people.name
        } else {
            people.name = "No Name"
            people.personTotalPrice = 0
            people.priceAfterDiscount = 0
            people.status = "Not Paid"
            addDetailButtonDidTap(self)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightTableView?.constant = self.tableView.contentSize.height
    }
    
    @IBAction func addDetailButtonDidTap(_ sender: Any) {
        let item = Item()
        item.itemName = "No item name"
        item.qty = 1
        item.price = 0
        items.append(item)
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        dismissKeyboard()
        
        if people.name != "" {
            people.name = nameTextField.text ?? "No Title"
        } else {
            people.name = "No Title"
        }
        people.items = items
        
        var error = false
        
        for item in items {
            if item.price == 0 {
                error = true
            }
        }
        
        if !error {
            if let navController = self.navigationController {
                self.delegate?.pass(people: people, indexOf: self.indexOf)
                navController.popViewController(animated: true)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
}

extension AddDetailViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddDetailTableViewCell", for: indexPath) as! AddDetailTableViewCell
        cell.itemTextField.delegate =  self
        cell.itemTextField.tag = indexPath.row
        cell.itemTextField.placeholder = "Item"
        //        cell.itemTextField.setBottomBorder()
        cell.itemTextField.addDoneButtonOnKeyboard()
        
        cell.qtyTextField.delegate =  self
        cell.qtyTextField.tag = indexPath.row
        cell.qtyTextField.placeholder = "Qty"
        cell.qtyTextField.addDoneButtonOnKeyboard()
        
        cell.priceTextField.delegate =  self
        cell.priceTextField.tag = indexPath.row
        cell.priceTextField.placeholder = "Price"
        cell.priceTextField.addDoneButtonOnKeyboard()
        
        if isEdit ?? false {
            let item = items[indexPath.row]
            cell.itemTextField.text = item.itemName
            let qtyString = Int(item.qty)
            cell.qtyTextField.text = String(qtyString)
            let priceString = Int(item.price)
            cell.priceTextField.text = String(priceString)
        }
        return cell
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.placeholder == "Item" {
            let indexOf = textField.tag
            
            items[indexOf].itemName = textField.text!
        } else if textField.placeholder == "Qty" {
            let indexOf = textField.tag
            
            let qty: Double = Double(textField.text!) ?? 0
            items[indexOf].qty = qty
        } else if textField.placeholder == "Price" {
            let indexOf = textField.tag
            
            let price: Double = Double(textField.text!) ?? 0
            items[indexOf].price = price
        }
    }
}
