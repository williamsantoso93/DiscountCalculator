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
    var personQty: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createLabelAndTextField()
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
        }
    }
    
    @objc func labelAndTextFieldDidTap(sender: UITextField!) {
        sender.resignFirstResponder()
    }
}
