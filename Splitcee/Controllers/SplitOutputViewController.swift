//
//  SplitOutputViewController.swift
//  Splitcee
//
//  Created by Mohammed Sadiq on 10/04/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class SplitOutputViewController: UIViewController {
    @IBOutlet weak var splitPerPersonLabel: UILabel!
    @IBOutlet weak var splitDescriptionLabel: UILabel!
    
    var split: Split!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splitPerPersonLabel.text = String(format:"%.2f", self.split.amountPerPerson)
        splitDescriptionLabel.text = "Split between \(split.personCount) people, with \(split.tipPercentage)% tip."
    }
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
