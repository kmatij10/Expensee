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
        self.expensesByCategory = expensesOutcomeForMonth().map { (category, expenses) in
            let totalOutcome = expenses.reduce(0) { $0 + $1.amount }
            let threshold = UserDefaults.standard.getLargeAmountThreshold(for: category)
            let largeAmount = totalOutcome > threshold ?? 100
            return ExpenseCategoryViewModel(category: category, amount: totalOutcome, largeAmount: largeAmount, threshold: threshold ?? 100)
        }
    }
}

private extension MonthDetailsViewModel {

    func expensesOutcomeForMonth() -> [ExpenseCategory: [ExpenseDataModel]] {
        let calendar = Calendar.current
        let filteredExpenses = expenses.filter { expense in
            if let createdAt = expense.createdAt {
                return calendar.component(.month, from: createdAt) == month && expense.expenseType == .outcome
            }
            return false
        }

        return Dictionary(grouping: filteredExpenses, by: { $0.expenseCategory ?? .other })
    }
}
