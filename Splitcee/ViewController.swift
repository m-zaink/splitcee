//
//  ViewController.swift
//  Splitcee
//
//  Created by Mohammed Sadiq on 07/04/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func splitChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
    }
}

enum Split: Int {
    case first = 0
    case second
    case third
    
    func getShare() -> Int {
        switch self {
        case .first:
            return 0
        case .second:
            return 10
        case .third:
            return 20
        }
    }
}
