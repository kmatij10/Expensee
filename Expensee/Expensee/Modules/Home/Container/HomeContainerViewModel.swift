//
//  HomeContainerViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

final class HomeContainerViewModel: ObservableObject {

    @Published var expenses: [ExpenseDataModel] = []
    var dataController: DataController

    init(dataController: DataController) {
        self.dataController = dataController
    }

    func fetchExpenses() {
        expenses = dataController.fetchExpenses()
    }

    func deleteExpense(expense: ExpenseDataModel) {
        let success = dataController.deleteExpense(with: expense)

        if success {
            fetchExpenses()
        }
    }
}
