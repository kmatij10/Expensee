//
//  CategoryThresholdViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import Foundation

class CategoryThresholdViewModel: ObservableObject {
    @Published var thresholds: [ExpenseCategory: String]

    let categories: [ExpenseCategory] = ExpenseCategory.allCases

    init() {
        var initialThresholds = [ExpenseCategory: String]()
        for category in ExpenseCategory.allCases {
            let threshold = UserDefaults.standard.getLargeAmountThreshold(for: category) ?? Constants.thresholdDefault
            initialThresholds[category] = "\(threshold)"
        }
        self.thresholds = initialThresholds
    }

    func saveThresholds() {
        for (category, amountString) in thresholds {
            if let amount = Double(amountString) {
                UserDefaults.standard.setLargeAmountThreshold(for: category, amount: amount)
            }
        }
    }
}
