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
        let enteredBillAmount: String = billAmountTextField.text!
        
        if enteredBillAmount.isEmpty {
            updatePlaceholder(of: billAmountTextField, with: "Please enter your bill amount first ...")
            return
        }
        
        billAmountTextField.endEditing(false)
        
        let billAmount: Double = Double(enteredBillAmount)!
        let peopleCount: Int = Int(peopleCountLabel.text!)!
        let tipSegment: Int = tipSegmentedControl.selectedSegmentIndex
        
        split = Split(billAmount: billAmount, among: peopleCount, with: tipSegment)
        
        performSegue(withIdentifier: "showSplit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showSplit") {
            let destination = segue.destination as! SplitOutputViewController
            destination.split = split
        }
    }
    
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        if (billAmountTextField.isEditing) {
            billAmountTextField.endEditing(false)
        }
    }
}

extension SplitInputViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if text.isEmpty {
            updatePlaceholder(of: textField, with: "Please enter the bill amount here ...")
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
