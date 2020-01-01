//
//  HomeViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit
import CoreData

protocol CreateReceiptReceiveData {
    func pass(people: People, indexOf: Int)  //data: string is an example parameter
}

class CreateReceiptViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var receiptView: UIView!
    
    @IBOutlet weak var heightTableViewPeople: NSLayoutConstraint!
    @IBOutlet weak var heightTableViewAdditionalPrice: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewPeople: UITableView!
    @IBOutlet weak var tableViewAdditionalPrice: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var paidByTextField: UITextField!
    
    var receipt = Receipt()
    var peoples: [People] = []{
        didSet{
            DispatchQueue.main.async {
                if self.peoples.count > 0 {
                    for indexOf in 0 ... (self.peoples.count - 1) {
                        self.peoples[indexOf].personTotalPrice = self.countTotalPrice(items: self.peoples[indexOf].items)
                    }
                }
                
                self.tableViewPeople.reloadData()
                super.updateViewConstraints()
                self.heightTableViewPeople?.constant = self.tableViewPeople.contentSize.height
            }
        }
    }
    
    var additionalPrices: [AdditionalFee] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableViewAdditionalPrice.reloadData()
                super.updateViewConstraints()
                self.heightTableViewAdditionalPrice?.constant = self.tableViewAdditionalPrice.contentSize.height
            }
        }
    }
    
    var isEdit: Bool = false
    var editedPeople = People()
    var indexOf = Int()
    
    var date = Date()
    
    let pickerAdditionalFeeData: [String] = ["Discount", "Tax", "Delivery Fee" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPeople.register(UINib.init(nibName: "PeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "PeopleTableViewCell")
        tableViewAdditionalPrice.register(UINib.init(nibName: "AdditionalFeeTableViewCell", bundle: nil), forCellReuseIdentifier: "AdditionalFeeTableViewCell")
        
        // Do any additional setup after loading the view.
        titleTextField.addDoneButtonOnKeyboard()
        titleTextField.setBottomBorder()
        paidByTextField.addDoneButtonOnKeyboard()
        paidByTextField.setBottomBorder()
        
        hideKeyboardWhenTappedAround()
        
        dateTextField.text = dateToString(date: Date())
        dateTextField.textColor = .lightGray
        dateTextField.setBottomBorder()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "en_UK") as Locale
        datePicker.addTarget(self, action: #selector(CreateReceiptViewController.datePickerValueChange(sender:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        dateTextField.addDoneButtonOnKeyboard()
        
        for type in pickerAdditionalFeeData {
            let additionalPrice = AdditionalFee()
            additionalPrice.type = type
            additionalPrice.price = 0
            additionalPrices.append(additionalPrice)
        }
        
        originScrollViewSize = scrollView.frame.size
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    var originScrollViewSize = CGSize()

    @objc func keyboardWillChange(notification: Notification) {

//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
//
//        if notification.name == UIResponder.keyboardWillShowNotification {
//            scrollView.frame.size = CGSize(width: originScrollViewSize.width, height: (originScrollViewSize.height + keyboardRect.height))
//
//        } else {
//            scrollView.frame.size = originScrollViewSize
//        }

//        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//
//        let keyboardScreenEndFrame = keyboardValue.cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
//
//        if notification.name == UIResponder.keyboardWillHideNotification {
//            scrollView.contentInset = .zero
//        } else {
//            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
//        }
//
//        scrollView.scrollIndicatorInsets = yourTextView.contentInset
//
//        let selectedRange = yourTextView.selectedRange
//        yourTextView.scrollRangeToVisible(selectedRange)
    }
    /*
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }

//            scrollView.frame.size = CGSize(width: originScrollViewSize.width, height: (originScrollViewSize.height + keyboardSize.height))
            if self.scrollView.frame.origin.y == 0 {
                self.scrollView.frame.origin.y -= keyboardSize.height
                self.scrollView.frame.size = CGSize(width: originScrollViewSize.width, height: (originScrollViewSize.height + keyboardSize.height))

            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        //        if self.view.frame.origin.y != 0 {
        //            self.view.frame.origin.y = 0
        //        }
        if self.scrollView.frame.origin.y != 0 {
            self.scrollView.frame.origin.y = 0
        }

//        scrollView.frame.size = originScrollViewSize
    }*/
//     @objc func keyboardWillShow(notification:NSNotification){
//
//         let userInfo = notification.userInfo!
//         var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//         keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//
//         var contentInset:UIEdgeInsets = self.scrollView.contentInset
//         contentInset.bottom = keyboardFrame.size.height + 20
//         scrollView.contentInset = contentInset
//     }
//
//     @objc func keyboardWillHide(notification:NSNotification){
//
//         let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//         scrollView.contentInset = contentInset
//     }
    

    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }

    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
    
    @objc func datePickerValueChange(sender: UIDatePicker) {
        date = sender.date
        dateTextField.text = dateToString(date: date)
        dateTextField.textColor = .black
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
        self.heightTableViewPeople?.constant = self.tableViewPeople.contentSize.height
        self.heightTableViewAdditionalPrice?.constant = self.tableViewAdditionalPrice.contentSize.height
    }
    
    func sumUpAddtionalFee(additionalFees: [AdditionalFee]) -> [AdditionalFee] {
        var additionalSummaryPrices: [AdditionalFee] = []
        
        for type in pickerAdditionalFeeData {
            var tempPrice: Double = 0
            
            for additionaPrice in additionalPrices {
                if additionaPrice.type == type {
                    tempPrice += additionaPrice.price
                }
            }
            
            let additionalSummaryPrice = AdditionalFee()
            additionalSummaryPrice.type = type
            additionalSummaryPrice.price = tempPrice
            
            additionalSummaryPrices.append(additionalSummaryPrice)
        }
        
        return additionalSummaryPrices
    }
    
    
    func countTotalPrice(items: [Item]) -> Double {
        var totalPrice: Double = 0
        
        for item in items {
            totalPrice += item.price * item.qty
        }
        
        return totalPrice
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        self.resignFirstResponder()
        self.view.endEditing(true)
        if receipt.title != "" {
            receipt.title = titleTextField.text ?? "No Title"
        } else {
            receipt.title = "No Title"
        }
        receipt.date = date
        receipt.paidBy = paidByTextField.text ?? "Me"
        
        receipt.peoples = peoples
        
        receipt.additionalPrices = sumUpAddtionalFee(additionalFees: additionalPrices)
        
        var error = false
        
        for peoplePrice in receipt.peoples {
            if peoplePrice.personTotalPrice == 0 {
                error = true
            }
        }
        
        if !error {
            performSegue(withIdentifier: "ResultPriceSegue", sender: self)
        }
    }
    
    @IBAction func addAdditonalFee(_ sender: Any) {
        let additionalPrice = AdditionalFee()
        additionalPrice.type = "Discount"
        additionalPrice.price = 0
        additionalPrices.append(additionalPrice)
    }
    
    @IBAction func addPeople(_ sender: Any) {
        performSegue(withIdentifier: "AddDetail", sender: self)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultPriceSegue" {
            let controller = segue.destination as! ResultPriceViewController
            controller.receipt = self.receipt
            controller.delagete = self as? HomeReceiveData
        }
        if segue.identifier == "AddDetail" {
            let controller = segue.destination as! AddDetailViewController
            controller.delegate = self
            controller.isEdit = isEdit
            controller.indexOf = indexOf
            if isEdit {
                controller.editedPeople = editedPeople
                
            }
        }
    }
}

extension CreateReceiptViewController: CreateReceiptReceiveData {
    func pass(people: People, indexOf: Int) { //conforms to protocol
        // implement your own implementation
        if !isEdit {
            peoples.append(people)
        } else {
            peoples[indexOf] = people
            isEdit = false
        }
    }
}

extension CreateReceiptViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if tableView == tableViewPeople {
            return peoples.count
        } else if tableView == tableViewAdditionalPrice {
            count = additionalPrices.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewPeople {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as! PeopleTableViewCell
            
            cell.nameTextField.delegate =  self
            cell.nameTextField.tag = indexPath.row
            cell.nameTextField.placeholder = "Name"
            cell.nameTextField.text = peoples[indexPath.row].name
            cell.nameTextField.addDoneButtonOnKeyboard()

            cell.priceTextField.delegate =  self
            cell.priceTextField.tag = indexPath.row
            cell.priceTextField.placeholder = "Price"
            let priceString = Int(peoples[indexPath.row].personTotalPrice).formattedWithSeparator
            cell.priceTextField.text = "Rp. \(priceString)"
            //        cell.priceTextField.setBottomBorder().name
            cell.priceTextField.addDoneButtonOnKeyboard()
            
            cell.nameLabel.text = peoples[indexPath.row].name
            cell.priceLabel.text = "Rp. \(priceString)"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalFeeTableViewCell", for: indexPath) as! AdditionalFeeTableViewCell
            
            cell.typeTextField.delegate =  self
            cell.typeTextField.tag = indexPath.row
            if additionalPrices[indexPath.row].type != nil {
                cell.typeTextField.text = additionalPrices[indexPath.row].type
            }
            cell.typeTextField.placeholder = "Type"
            //        cell.nameTexfField.setBottomBorder()
            cell.typeTextField.addDoneButtonOnKeyboard()
            
            cell.priceTextField.delegate =  self
            cell.priceTextField.tag = indexPath.row
            cell.priceTextField.placeholder = "Additonal"
            //        cell.priceTextField.setBottomBorder()
            cell.priceTextField.addDoneButtonOnKeyboard()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == tableViewPeople {
                peoples.remove(at: indexPath.row)
            } else {
                additionalPrices.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var action: [UITableViewRowAction] = []
        if tableView == tableViewPeople {
            
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                // delete item at indexPath
                self.peoples.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            action.append(delete)
            
            let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
                // edit item at indexPath
                self.editedPeople = self.peoples[indexPath.row]
                self.isEdit = true
                self.indexOf = indexPath.row
                self.performSegue(withIdentifier: "AddDetail", sender: self)
            }
            edit.backgroundColor = UIColor.green
            action.append(edit)
        } else {
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                self.additionalPrices.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            action.append(delete)
        }
        
        return action
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.placeholder == "Name" {
            let indexOf = textField.tag
            
            peoples[indexOf].name = textField.text!
        } else if textField.placeholder == "Price" {
        } else if textField.placeholder == "Type" {
            let indexOf = textField.tag
            
            additionalPrices[indexOf].type = textField.text!
        } else if textField.placeholder == "Additonal" {
            let indexOf = textField.tag
            
            let price: Double = Double(textField.text!) ?? 0
            additionalPrices[indexOf].price = price
        }
    }
}


