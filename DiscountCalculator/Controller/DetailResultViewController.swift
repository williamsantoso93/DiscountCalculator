//
//  DetailResultViewController.swift
//  DiscountCalculator
//
//  Created by William Santoso on 15/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit

class DetailResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var text: String = "Hello World"
    
    @IBAction func swipeDown(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func tapView(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func shareButtonDidTap(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
}
