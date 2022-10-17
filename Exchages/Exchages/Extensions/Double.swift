//
//  Double.swift
//  Exchages
//
//  Created by Dario Gallegos on 17/10/22.
//

import Foundation

extension Double {
    
    /// Converts a Double into Currency with 2 - 6 decimals
    ///```
    ///Convert 1234.56 to €1.234,56
    ///Convert 12.3456 to €12,3456
    ///Convert 1.23456 to €0,123456
    ///```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // default
        //change currencyCode and Symbol
//        formatter.currencyCode = "eur"
//        formatter.currencySymbol = "€"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a Currency into  a String with 2 - 6 decimals
    ///```
    ///Convert 1234.56 to €1.234,56
    ///Convert 12.3456 to €12,3456
    ///Convert 1.23456 to €0,123456
    ///```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self )
        return currencyFormatter6.string(from: number) ?? "€0.00"
    }
    
    /// Converts a Double  into  String
    ///```
    ///Convert 1.23456 to "1.23"
    ///```
    func asNumberString() -> String {
        return String(format: "%.2f ", self)
    }
    
    /// Converts a Double  into  string representation with percent symbol
    ///```
    ///Convert 1.23456 to "1.23%"
    ///```
    func asPercentString() -> String {
         return asNumberString() + "%"
    }
}
