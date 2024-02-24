//
//  AddExpenseViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import CoreData

class AddExpenseViewModel: ObservableObject {
    @Published var type = ""
    @Published var amount = ""
    @Published var subtitle = ""
    @Published var category = ""
    @Published var createdAt = Date()

    @Published var saveSuccessful = false

    private let dataController: DataController
    private let expenseModel: ExpenseDataModel?

    init(expenseModel: ExpenseDataModel?) {
        self.expenseModel = expenseModel
        dataController = DataController()

        if let expense = expenseModel {
            type = expense.type ?? ""
            amount = String(expense.amount)
            subtitle = expense.subtitle ?? ""
            category = expense.category ?? ""
            createdAt = expense.createdAt ?? Date()
        }
    }

    func saveExpense(managedObjectContext: NSManagedObjectContext) {
        let amountStr = amount.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let amount = Double(amountStr) else {
            return
        }

        let success = dataController.addOrUpdateExpense(
            with: expenseModel,
            type: type,
            subtitle: subtitle,
            amount: amount,
            category: category,
            occurredOn: createdAt,
            context: managedObjectContext
        )

        if success {
            saveSuccessful = true
        }
    }
}
