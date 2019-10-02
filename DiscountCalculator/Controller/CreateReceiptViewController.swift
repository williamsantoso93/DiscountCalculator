//
//  HomeViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class CreateReceiptViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPeople.register(UINib.init(nibName: "PeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "PeopleTableViewCell")
        tableViewAdditionalPrice.register(UINib.init(nibName: "AdditionalFeeTableViewCell", bundle: nil), forCellReuseIdentifier: "AdditionalFeeTableViewCell")
//        heightTableViewParticipant.constant = tableViewParticipant.contentSize.height
//        heightTableViewAdditionalPrice.constant = tableViewPeople.contentSize.height
        
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
        
        let pickerAdditionalFeeData: [String] = ["Discount", "Tax", "Delivery Fee" ]
        
        for type in pickerAdditionalFeeData {
            let additionalPrice = AdditionalFee()
            additionalPrice.type = type
            additionalPrice.price = 0
            additionalPrices.append(additionalPrice)
        }
        
        let people = People()
        people.name = "No Name"
        people.price = 0
        people.priceAfterDiscount = 0
        people.status = "Not Paid"
        peoples.append(people)
        
        originScrollViewSize = scrollView.frame.size
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    var originScrollViewSize = CGSize()
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.frame.size = CGSize(width: originScrollViewSize.width, height: (originScrollViewSize.height - keyboardRect.height))

        } else {
            scrollView.frame.size = originScrollViewSize
        }
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
        receipt.additionalPrices = additionalPrices
        
        var error = false
        
        for peoplePrice in receipt.peoples {
            if peoplePrice.price == 0 {
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
//        let people = People()
//        people.name = "No Name"
//        people.price = 0
//        people.priceAfterDiscount = 0
//        people.status = "Not Paid"
//        peoples.append(people)
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
        }
    }
}

extension CreateReceiptViewController: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == tableViewPeople {
                peoples.remove(at: indexPath.row)
            } else {
                additionalPrices.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if tableView == tableViewPeople {
            count = peoples.count
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
            //        cell.nameTexfField.setBottomBorder()
            cell.nameTextField.addDoneButtonOnKeyboard()
            
            cell.priceTextField.delegate =  self
            cell.priceTextField.tag = indexPath.row
            cell.priceTextField.placeholder = "Price"
            //        cell.priceTextField.setBottomBorder()
            cell.priceTextField.addDoneButtonOnKeyboard()
            
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.placeholder == "Name" {
            let indexOf = textField.tag
            
            peoples[indexOf].name = textField.text!
        } else if textField.placeholder == "Price" {
            let indexOf = textField.tag
            
            let price: Double = Double(textField.text!) ?? 0
            peoples[indexOf].price = price
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


