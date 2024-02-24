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

    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("Data could not be saved, possibly not enough storage space")
        }
    }

    func addExpense(
        title: String,
        subtitle: String,
        amount: Double,
        category: String,
        context: NSManagedObjectContext
    ) {
        let expense = Expense(context: context)
        expense.id = UUID()
        expense.createdAt = Date()
        expense.updatedAt = Date()
        expense.title = title
        expense.subtitle = subtitle
        expense.amount = amount
        expense.category = category

        save(context: context)
    }

    func editExpense(
        expense: Expense,
        title: String,
        subtitle: String,
        amount: Double,
        category: String,
        context: NSManagedObjectContext
    ) {
        expense.updatedAt = Date()
        expense.title = title
        expense.subtitle = subtitle
        expense.amount = amount
        expense.category = category

        save(context: context)
    }
}
