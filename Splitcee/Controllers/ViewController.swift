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
    @IBOutlet weak var splitSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        billAmountTextField.delegate = self
    }
    
    @IBAction func splitChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        peopleCountLabel.text = String(Int(sender.value))
    }
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        billAmountTextField.endEditing(true)
        if (billAmountTextField.text!.isEmpty) {
            _ = shouldEndEditing(billAmountTextField)
            return
        }
        
        if (!billAmountTextField.isEditing) {
            let peopleCount: Int = Int(peopleCountLabel.text!)!
            print(peopleCount)
            let billAmount: Double = Double(billAmountTextField.text!)!
            print(billAmount)
            let tipPercentage: Double = Double(Split(rawValue: splitSegment.selectedSegmentIndex)!.getShare()) / 100.0
            print(tipPercentage)
            
            let finalBill: Double = billAmount * (1.0 + tipPercentage)
            print("Final bill \(finalBill)")
            let perPersonSplit: Double = finalBill / Double(peopleCount)
            print("Per person split: \(perPersonSplit)")
            
            performSegue(withIdentifier: "showSplit", sender: self)
        }
    }
    
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        if (billAmountTextField.isEditing) {
            billAmountTextField.endEditing(true)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return shouldEndEditing(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return shouldEndEditing(textField)
    }
    
    func shouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            textField.placeholder = "Please enter your bill amount here."
            return false
        } else if !textField.text!.isValidNumber {
            textField.text = ""
            textField.placeholder = "Please enter a valid number"
            return false
        }
        
        return true
    }
}

extension String {
    var isValidNumber: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]{0,8}(.[0-9]{1,4})?$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
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
