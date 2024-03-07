//
//  HomeContainerViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI
import Combine

final class HomeContainerViewModel: ObservableObject {

    @Published var expenses: [ExpenseDataModel] = []
    @Published var error: Error?
    @Published var showErrorAlert = false
    var dataController: DataController

    init(dataController: DataController) {
        self.dataController = dataController

        dataController.$expenses
            .assign(to: &$expenses)
        dataController.$error
            .assign(to: &$error)
        dataController.$showErrorAlert
            .assign(to: &$showErrorAlert)
    }

    func deleteExpense(expense: ExpenseDataModel) {
        _ = dataController.deleteExpense(with: expense)
    }
}
