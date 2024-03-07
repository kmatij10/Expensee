//
//  DataController.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import CoreData
import Combine

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: Constants.expenseModel)

    @Published var expenses: [ExpenseDataModel] = []
    @Published var error: Error?
    @Published var showErrorAlert = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadContainerAndSubscribe()
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

private extension DataController {

    func loadContainerAndSubscribe() {
        container.loadPersistentStores { [weak self] description, error in
            guard let self else {
                return
            }
            if let error = error {
                self.error = error
                showErrorAlert = true
            } else {
                fetchExpenses()
            }
        }

        NotificationCenter
            .default
            .publisher(for: NSNotification.Name.NSManagedObjectContextDidSave, object: container.viewContext)
            .sink { [weak self] _ in
                self?.fetchExpenses()
            }
            .store(in: &cancellables)
    }

    func save() -> Bool {
        do {
            try container.viewContext.save()
            return true
        } catch {
            self.error = error
            showErrorAlert = true
            return false
        }
    }

    func fetchExpenses() {
        let fetchRequest: NSFetchRequest<ExpenseDataModel> = ExpenseDataModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ExpenseDataModel.createdAt, ascending: false)]

        do {
            expenses = try container.viewContext.fetch(fetchRequest)
        } catch {
            self.error = error
            expenses = []
            showErrorAlert = true
        }
    }
}
