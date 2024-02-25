//
//  DoubleExtension.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation

extension Double {

    var formattedCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
        return formatter.string(from: NSNumber(value: self)) ?? "€0.00"
    }
}
