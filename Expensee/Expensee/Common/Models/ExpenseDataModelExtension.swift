//
//  ExpenseDataModelExtension.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import CoreData

enum ExpenseType: String, Codable, CaseIterable {
    case income
    case outcome

    var text: String {
        switch self {
        case .income:
            return "Income"
        case .outcome:
            return "Outcome"
        }
    }
}

enum ExpenseCategory: String, Codable, CaseIterable {
    case food
    case drinks
    case car
    case bills
    case other

    var text: String {
        switch self {
        case .food:
            return "Food"
        case .drinks:
            return "Drinks"
        case .car:
            return "Car"
        case .bills:
            return "Bills"
        case .other:
            return "Other"
        }
    }
}

extension ExpenseDataModel {
    
    var expenseType: ExpenseType? {
        get {
            guard let type = self.type else { return nil }
            return ExpenseType(rawValue: type)
        }
        set {
            self.type = newValue?.rawValue
        }
    }

    var expenseCategory: ExpenseCategory? {
        get {
            guard let category = self.category else { return nil }
            return ExpenseCategory(rawValue: category)
        }
        set {
            self.category = newValue?.rawValue
        }
    }
}
