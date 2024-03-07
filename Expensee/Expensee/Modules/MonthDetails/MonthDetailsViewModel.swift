//
//  MonthDetailsViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI
import Combine

final class MonthDetailsViewModel: ObservableObject {
    private var expenses: [ExpenseDataModel]
    private let month: Int
    private var cancellables = Set<AnyCancellable>()
    let dataController: DataController

    @Published var expensesByCategory: [ExpenseCategoryViewModel] = []

    init(dataController: DataController, expenses: [ExpenseDataModel], month: Int) {
        self.dataController = dataController
        self.expenses = expenses
        self.month = month

        UserDefaults.standard.largeAmountThresholdsPublisher
            .sink { [weak self] _ in
                self?.refreshCategories()
            }
            .store(in: &cancellables)
    }

    func refreshCategories() {
        self.expensesByCategory = expensesForMonth().map { (category, expenses) in
            let totalIncome = expenses.reduce(0) { $0 + ($1.expenseType == .income ? $1.amount : 0) }
            let totalOutcome = expenses.reduce(0) { $0 + ($1.expenseType == .outcome ? $1.amount : 0) }
            let totalAmount = totalIncome - totalOutcome
            let threshold = UserDefaults.standard.getLargeAmountThreshold(for: category)
            let largeAmount = totalAmount > threshold ?? 100
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
