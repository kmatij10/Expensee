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
    case snacks
    case cosmetics
    case glutenFree
    case drinks
    case sport
    case delivery
    case streaming
    case gas
    case car
    case credit
    case education
    case health
    case cigarettes
    case household
    case hobbies
    case clothing
    case repairs
    case installments
    case greenMarket
    case supplements
    case beauty
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
        case .snacks:
            return Constants.snacks
        case .cosmetics:
            return Constants.cosmetics
        case .glutenFree:
            return Constants.glutenFree
        case .sport:
            return Constants.sport
        case .delivery:
            return Constants.delivery
        case .streaming:
            return Constants.streaming
        case .gas:
            return Constants.gas
        case .credit:
            return Constants.credit
        case .education:
            return Constants.education
        case .health:
            return Constants.health
        case .cigarettes:
            return Constants.cigarettes
        case .household:
            return Constants.household
        case .hobbies:
            return Constants.hobbies
        case .clothing:
            return Constants.clothing
        case .repairs:
            return Constants.repairs
        case .installments:
            return Constants.installments
        case .greenMarket:
            return Constants.greenMarket
        case .supplements:
            return Constants.supplements
        case .beauty:
            return Constants.beauty
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
