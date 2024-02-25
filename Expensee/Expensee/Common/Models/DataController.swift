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

    func save() -> Bool {
        do {
            try container.viewContext.save()
            return true
        } catch {
            print("Something went wrong: \(error.localizedDescription)")
            return false
        }
    }

    func fetchExpenses() -> [ExpenseDataModel] {
        let request: NSFetchRequest<ExpenseDataModel> = ExpenseDataModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ExpenseDataModel.createdAt, ascending: false)]

        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }


    func deleteExpense(with model: ExpenseDataModel) -> Bool {
        container.viewContext.delete(model)

        return save()
    }

    func addOrUpdateExpense(
        with model: ExpenseDataModel?,
        type: ExpenseType,
        subtitle: String?,
        amount: Double,
        category: ExpenseCategory,
        createdAt: Date
    ) -> Bool {
        let expense: ExpenseDataModel
        if let model {
            expense = model
        } else {
            expense = ExpenseDataModel(context: container.viewContext)
            expense.id = UUID()
        }
        expense.createdAt = createdAt
        expense.expenseType = type
        expense.subtitle = subtitle
        expense.amount = amount
        expense.expenseCategory = category

        return save()
    }
}
