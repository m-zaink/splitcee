//
//  extensions.swift
//  Splitcee
//
//  Created by Mohammed Sadiq on 10/04/20.
//  Copyright © 2020 Mohammed Sadiq. All rights reserved.
//

import Foundation

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
