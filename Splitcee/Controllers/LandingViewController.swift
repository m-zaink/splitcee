//
//  ViewController.swift
//  Splitcee
//
//  Created by Mohammed Sadiq on 07/04/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import UIKit

class SplitInputViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    var split: Split!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmountTextField.delegate = self
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
            let billAmount: Double = Double(billAmountTextField.text!)!
            let tipSegment: Int = tipSegmentedControl.selectedSegmentIndex
            
            split = Split(billAmount: billAmount, among: peopleCount, with: tipSegment)
        }
    }
    
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        if (billAmountTextField.isEditing) {
            billAmountTextField.endEditing(true)
        }
    }
}

extension SplitInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if text.isEmpty {
            updatePlaceholder(of: textField, with: "Please enter your bill amount here ...")
            return false
        }
        
        if text.isInvalidDecimalNumber  {
            updatePlaceholder(of: textField, with: "Please enter a valid bill amount ...")
            return false
        }
        
        return true
    }
    
    func updatePlaceholder(of textField: UITextField, with placeholder: String) {
        textField.text = ""
        textField.placeholder = placeholder
    }
}

extension String {
    var isValidDecimalNumber: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]{0,8}(.[0-9]{1,4})?$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isInvalidDecimalNumber: Bool {
        return !isValidDecimalNumber
    }
}
