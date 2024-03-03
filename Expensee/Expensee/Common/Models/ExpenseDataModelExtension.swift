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
            return Constants.income
        case .outcome:
            return Constants.outcome
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
            return Constants.food
        case .drinks:
            return Constants.drinks
        case .car:
            return Constants.car
        case .bills:
            return Constants.bills
        case .other:
            return Constants.other
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
