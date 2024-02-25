//
//  MonthDetailsViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

final class MonthDetailsViewModel: ObservableObject {
    private let expenses: [ExpenseDataModel]
    private let month: Int
    let dataController: DataController

    init(dataController: DataController, expenses: [ExpenseDataModel], month: Int) {
        self.dataController = dataController
        self.expenses = expenses
        self.month = month
    }

    var expensesByCategory: [ExpenseCategoryViewModel] {
        expensesForMonth().map { (category, expenses) in
            let totalAmount = expenses.reduce(0) { $0 + $1.amount }
            let largeAmount = totalAmount > 10
            return ExpenseCategoryViewModel(category: category, amount: totalAmount, largeAmount: largeAmount)
        }
    }
}

private extension MonthDetailsViewModel {

    func expensesForMonth() -> [ExpenseCategory: [ExpenseDataModel]] {
        let calendar = Calendar.current
        let filteredExpenses = expenses.filter { expense in
            if let createdAt = expense.createdAt {
                return calendar.component(.month, from: createdAt) == month
            }
            return false
        }

        return Dictionary(grouping: filteredExpenses, by: { $0.expenseCategory ?? .other })
    }
}
