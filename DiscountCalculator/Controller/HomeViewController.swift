//
//  Home2ViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 12/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit
import CoreData

protocol HomeReceiveData {
    func pass(receipt:  Receipt)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var emptyDataView: UIView!
    @IBOutlet weak var splitButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataReceipts : [DataReceipt]? //array of receipt
//    var loadDataReceipts : [DataReceipt]? //array of receipt
    var selectedReceipt = Receipt()
    
    var receipts: [Receipt] = [] {
        didSet {
            DispatchQueue.main.async {
                self.receipts = self.receipts.sorted(by: {$0.date > $1.date})
            }
        }
    }
    
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "ListReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ListReceiptTableViewCell")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        //add refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl.backgroundColor =  .white
        tableView.addSubview(refreshControl) // not required when using UITableViewController

        
        // Do any additional setup after loading the view.
        splitButton.rounded()
        
        if #available(iOS 13.0, *) {
//            navigationItem.largeTitleDisplayMode = .never
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            navigationItem.largeTitleDisplayMode = .always
        }
        
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        self.receipts = self.receipts.sorted(by: {$0.date > $1.date})
        tableView.reloadData()
        print(UserDefaults.standard.integer(forKey: "lastID"))
    }

    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        loadData()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    var a: Double = 0
    var b: Int64 = 0
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("error : ", error)
        }
    }
    
    func loadData() {
        let request: NSFetchRequest = DataReceipt.fetchRequest()
        
        do {
            dataReceipts = try context.fetch(request)
            
        } catch {
            print("error parah : ", error)
        }
        receipts.removeAll()
        
        for loadDataReceipt in dataReceipts! {
            do {
                let decodeReceipt = try decoder.decode(Receipt.self, from: (loadDataReceipt.receipt?.data(using: .utf8))!)
                receipts.append(decodeReceipt)
            } catch {
                
            }
        }
        
    }
    
    func deleteData(id: Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataReceipt")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
       
        do
        {
           let test = try context.fetch(fetchRequest)
           
           let objectToDelete = test[0] as! NSManagedObject
           context.delete(objectToDelete)
           
           do{
               try context.save()
           }
           catch
           {
               print(error)
           }
           
        }
        catch
        {
           print(error)
        }
    }

    @IBAction func addList(_ sender: Any) {
        performSegue(withIdentifier: "CreateReceipt", sender: self)
//        let receipt = Receipt()

//        receipt.title = "hello"
//        receipt.date = Date()
//        receipt.paidBy = "me"
//        receipt.totalPrice = a
//        receipts.append(receipt)
//        a += 1
//        b += 1
//        tableView.reloadData()
//        do {
//            // 1
//            print("encode :")
//            let data = try encoder.encode(receipt)
//            // 2
//            let encodeReceipt = String(data: data, encoding: .utf8)!
//            print(encodeReceipt)
//            print("decode :")
//            let decodeReceipt = try decoder.decode(Receipt.self, from: data)
//
//            print(decodeReceipt.totalPrice)
//
//            let receiptData = DataReceipt(context: self.context)
//
//            receiptData.receipt = encodeReceipt
//
//            dataReceipts?.append(receiptData)
//            saveData()
//
//        } catch {
//          // Handle error
//        }
//
//
//        loadData()
        
//        print("data :")
//        for loadDataReceipt in loadDataReceipts! {
//            print(loadDataReceipt.id)
//            print(loadDataReceipt.receipt!)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultPrice" {
            let controller = segue.destination as! ResultPriceViewController
            controller.receipt = self.selectedReceipt
            controller.fromHome = true
//            controller.delagete = self as? HomeReceiveData
        }
        
    }
    
    @IBAction func splitButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "CreateReceipt", sender: self)
    }
}

extension HomeViewController: HomeReceiveData {
    func pass(receipt: Receipt) {
        do {
            let data = try encoder.encode(receipt)
            let encodeReceipt = String(data: data, encoding: .utf8)!
            let receiptData = DataReceipt(context: self.context)

            receiptData.receipt = encodeReceipt

            dataReceipts?.append(receiptData)
            saveData()

        } catch {
          // Handle error
        }
//        receipts.append(receipt)
        loadData()
        tableView.reloadData()
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
        
        let totalPriceString = Int(receipts[indexPath.row].totalPrice).formattedWithSeparator
        
        cell.receiptTotalPriceLabel.text = "Rp. \(totalPriceString)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedReceipt = receipts[indexPath.row]
        performSegue(withIdentifier: "ResultPrice", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            receipts.remove(at: indexPath.row)
            
            let selectedDataReceipt = dataReceipts![indexPath.row]
            let selectedIdDataReceipt: Int = Int(selectedDataReceipt.id)
            
            deleteData(id: selectedIdDataReceipt)
//            dataReceipts?.remove(at: indexPath.row)
//            self.context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
//            saveData()

//            print(dataReceipts?.count)
            
            loadData()
            tableView.reloadData()
//            print(dataReceipts?.count)
//            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .automatic)
//            tableView.endUpdates()
        }
    }
}
