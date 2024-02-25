//
//  DataController.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ExpenseModel")

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Failed to load data, \(error.localizedDescription)")
            }
        }
    }

    func addOrUpdateExpense(
        with model: ExpenseDataModel?,
        type: ExpenseType,
        subtitle: String?,
        amount: Double,
        category: ExpenseCategory,
        createdAt: Date,
        context: NSManagedObjectContext
    ) -> Bool {
        let expense: ExpenseDataModel
        if let model {
            expense = model
        } else {
            expense = ExpenseDataModel(context: context)
            expense.id = UUID()
        }
        expense.createdAt = createdAt
        expense.expenseType = type
        expense.subtitle = subtitle
        expense.amount = amount
        expense.expenseCategory = category

        do {
            try context.save()
            return true
        } catch {
            print("Failed to save expense: \(error.localizedDescription)")
            return false
        }
    }
}
