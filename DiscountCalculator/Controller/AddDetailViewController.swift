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
    
    var peoples: [People] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                super.updateViewConstraints()
                self.heightTableView?.constant = self.tableView.contentSize.height
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: "AddDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AddDetailTableViewCell")
        // Do any additional setup after loading the view.
        
        let people = People()
        people.name = "No Name"
        people.price = 0
        people.priceAfterDiscount = 0
        people.status = "Not Paid"
        peoples.append(people)
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.heightTableView?.constant = self.tableView.contentSize.height
    }
    
    @IBAction func addDetailButtonDidTap(_ sender: Any) {
        let people = People()
        people.name = "No Name"
        people.price = 0
        people.priceAfterDiscount = 0
        people.status = "Not Paid"
        peoples.append(people)
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            peoples.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddDetailTableViewCell", for: indexPath) as! AddDetailTableViewCell
        
        return cell
    }
    
}
