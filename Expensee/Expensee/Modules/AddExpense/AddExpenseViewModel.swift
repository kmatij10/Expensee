//
//  AddExpenseViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import CoreData
import Combine

final class AddExpenseViewModel: ObservableObject {
    @Published var type: ExpenseType = .income
    @Published var amount = ""
    @Published var subtitle = ""
    @Published var category: ExpenseCategory = .other
    @Published var createdAt = Date()
    @Published var saveSuccessful = false
    @Published var error: Error?
    @Published var showErrorAlert = false

    private let dataController: DataController
    private let expenseModel: ExpenseDataModel?

    let typeOptions: [DropdownOption] = ExpenseType.allCases.map {
        DropdownOption(key: $0.rawValue, value: $0.text)
    }

    let categoryOptions = ExpenseCategory.allCases.map {
        DropdownOption(key: $0.rawValue, value: $0.text)
    }

    init(expenseModel: ExpenseDataModel?, dataController: DataController) {
        self.expenseModel = expenseModel
        self.dataController = dataController

        if let expense = expenseModel {
            type = expense.expenseType ?? .income
            amount = String(expense.amount)
            subtitle = expense.subtitle ?? ""
            category = expense.expenseCategory ?? .other
            createdAt = expense.createdAt ?? Date()
        }
        
        dataController.$error
            .assign(to: &$error)
        dataController.$showErrorAlert
            .assign(to: &$showErrorAlert)
    }

    var titleText: String {
        expenseModel == nil ? Constants.addTransactionAction : Constants.updateTransactionAction
    }

    var typeDisplayText: String {
        type.text
    }

    var categoryDisplayText: String {
        category.text
    }

    var alertTitle: String {
        Constants.oops
    }

    var alertMessage: String {
        error?.localizedDescription ?? Constants.unexpectedError
    }

    func saveExpense() {
        let amountStr = amount.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let amount = Double(amountStr)
        else {
            return
        }

        let success = dataController.addOrUpdateExpense(
            with: expenseModel,
            type: type,
            subtitle: subtitle,
            amount: amount,
            category: category,
            createdAt: createdAt
        )

        if success {
            saveSuccessful = true
        }
    }
}
