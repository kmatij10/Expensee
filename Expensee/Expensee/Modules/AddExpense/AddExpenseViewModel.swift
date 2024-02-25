//
//  AddExpenseViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import CoreData

final class AddExpenseViewModel: ObservableObject {
    @Published var type: ExpenseType = .income
    @Published var amount = ""
    @Published var subtitle = ""
    @Published var category: ExpenseCategory = .other
    @Published var createdAt = Date()
    @Published var saveSuccessful = false

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
    }

    var titleText: String {
        expenseModel == nil ? "Add transaction" : "Update transaction"
    }

    var typeDisplayText: String {
        type.text
    }

    var categoryDisplayText: String {
        category.text
    }
    
    func saveExpense(managedObjectContext: NSManagedObjectContext) {
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
            createdAt: createdAt,
            context: managedObjectContext
        )

        if success {
            saveSuccessful = true
        }
    }
}
