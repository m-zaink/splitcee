//
//  Split.swift
//  Splitcee
//
//  Created by Mohammed Sadiq on 10/04/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

struct Split {
    let billAmount: Double
    let tipSegment: Int
    let personCount: Int
    
    init(billAmount: Double, among personCount: Int, with tipSegment: Int) {
        self.billAmount = billAmount
        self.personCount = personCount
        self.tipSegment = tipSegment
    }
    
    var tipPercentage: Double {
        switch tipSegment {
        case 0:
            return 0.0
        case 1:
            return 10.0
        default:
            return 20.0
        }
    }
    
    var amountPerPerson: Double {
        let amountPerPerson: Double = (billAmount * (1.0 + tipPercentage / 100.0)) / Double(personCount)
        
        return amountPerPerson
    }
}
