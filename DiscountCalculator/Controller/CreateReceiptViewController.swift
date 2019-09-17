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
    
    var debtsData = [DebtData]() { // Keranjang Data Buku dari Server
        didSet{
//            DispatchQueue.main.async {
//                self.tableViewParticipant.reloadData()
//                super.updateViewConstraints()
//                self.heightTableViewParticipant?.constant = self.tableViewParticipant.contentSize.height
//            }
        }
    }
    
    @IBOutlet weak var heightTableViewParticipant: NSLayoutConstraint!
    
    @IBOutlet weak var heightTableViewAdditionalPrice: NSLayoutConstraint!
    
    var discount: Double?
    var ongkir: Double?
    var pajak: Double?
    var priceOngkirPerPerson = Double()
    
    @IBOutlet weak var tableViewParticipant: UITableView!
    @IBOutlet weak var tableViewAdditionalPrice: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var paidByTextField: UITextField!
    
    var receipt = Receipt()
    var peoples: [People] = []{ // Keranjang Data Buku dari Server
        didSet{
            DispatchQueue.main.async {
                self.tableViewParticipant.reloadData()
                super.updateViewConstraints()
                self.heightTableViewParticipant?.constant = self.tableViewParticipant.contentSize.height
            }
        }
    }
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewParticipant.register(UINib.init(nibName: "CreditTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditTableViewCell")
//        heightTableViewParticipant.constant = tableViewParticipant.contentSize.height
        heightTableViewAdditionalPrice.constant = tableViewParticipant.contentSize.height
        
        // Do any additional setup after loading the view.
        
        dateTextField.text = dateToString(date: Date())
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "en_UK") as Locale
        datePicker.addTarget(self, action: #selector(CreateReceiptViewController.datePickerValueChange(sender:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        dateTextField.addDoneButtonOnKeyboard()
    }
    
    @objc func datePickerValueChange(sender: UIDatePicker) {
        date = sender.date
        dateTextField.text = dateToString(date: date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightTableViewParticipant?.constant = self.tableViewParticipant.contentSize.height
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
//        scrollView.contentOffset.y =  scrollView.contentOffset.y  + 10
        receipt.title = titleTextField.text ?? "No Title"
        receipt.date = date
        receipt.paidBy = paidByTextField.text ?? "Me"
        receipt.peoples = peoples
        performSegue(withIdentifier: "ResultPriceSegue", sender: self)
    }
    
    @IBAction func spiltButtonDidTap(_ sender: Any) {
//        performSegue(withIdentifier: "DetailPriceSegue", sender: self)
        receipt.title = titleTextField.text ?? "No Title"
        receipt.date = date
        receipt.paidBy = paidByTextField.text ?? "Me"
        receipt.peoples = peoples
        performSegue(withIdentifier: "ResultPriceSegue", sender: self)
    }
    
    @IBAction func addCredit(_ sender: Any) {
//        let testData = DebtData()
//        testData.name = "Aji"
//        testData.price = "10000"
//        debtsData.append(testData)
        let people = People()
        people.name = "No Name"
        people.price = 0
        peoples.append(people)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "AddPriceSegue" {
//            let controller = segue.destination as! AddPriceViewController
//            controller.delegate = self
//        }
//        if segue.identifier == "DetailPriceSegue" {
//            let controller = segue.destination as! DebtsProcessViewController
//            controller.delegate = self
//        }
        if segue.identifier == "ResultPriceSegue" {
            let controller = segue.destination as! ResultPriceViewController
            controller.receipt = self.receipt
//            controller.debtsData = self.debtsData
//            controller.priceOngkirPerPerson = self.priceOngkirPerPerson
        }
        
    }

}

extension CreateReceiptViewController: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditTableViewCell", for: indexPath) as! CreditTableViewCell
//        cell.label.text = "\(indexPath.row + 1)"
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
//        let debts = debtsData[indexPath.row]
//        cell.nameLabel.text = debts.name
//        cell.priceLabel.text = debts.price
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.placeholder == "Name" {
            let indexOf = textField.tag
            
            peoples[indexOf].name = textField.text!
        } else if textField.placeholder == "Price" {
            let indexOf = textField.tag
            
            let price: Double = Double(textField.text!) ?? 0
            peoples[indexOf].price = price
        }
    }
}

//extension CreateReceiptViewController: AddPriceViewControllerDelegate{
//    func addValue(name: String, price: String) {
//        var data = DebtData.init()
//        data.name = name
//        data.price = price
//        debtsData.append(data)
//        tableViewParticipant.reloadData()
//    }
//}
//
//extension CreateReceiptViewController: DebtsProcessViewControllerDelegate {
//    func processDebts(deliveryFee: String?, discount: String?, tax: String?) {
//        self.discount = Double(discount!)
//        self.ongkir = Double(deliveryFee!)
//        self.pajak = Double(tax!)
//        countDiscount()
//        performSegue(withIdentifier: "ResultPriceSegue", sender: self)
//    }
//
//    func countDiscount() {
//        var totalPrice: Double = 0
//        for data in debtsData {
//            totalPrice += Double(data.price!)!
//        }
//
//        let persenDiscount = (discount ?? 0) / totalPrice
//        let persenPajak = (pajak!) / totalPrice
//        priceOngkirPerPerson = ongkir! / Double(debtsData.count)
//
//        for var data in debtsData {
//            let priceDiscount = Double(data.price!)! * persenDiscount
//            let priceAfterDiscount = Double(data.price!)! - priceDiscount
//            let pricePajak = Double(data.price!)! * persenPajak
//            let priceAfterDiscountPajak = priceAfterDiscount + pricePajak
//            let priceAfterDiscountPajakOngkir = priceAfterDiscountPajak + priceOngkirPerPerson
//
//            data.priceDiscount = priceDiscount
//            data.priceAfterDiscount = priceAfterDiscount
//            data.pricePajak = pricePajak
//            data.priceAfterDiscountPajakOngkir = priceAfterDiscountPajakOngkir
//        }
//    }
//}
//
