//
//  HomeViewModel.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation

final class HomeViewModel: ObservableObject {
    let month: Int
    let containerViewModel: HomeContainerViewModel
    let dataController: DataController

    var expenses: [ExpenseDataModel] {
        containerViewModel.expenses.filter { expense in
            Calendar.current.component(.month, from: expense.createdAt ?? Date()) == month
        }
    }

    let maxAngle: Double = 270

    init(
        month: Int,
        containerViewModel: HomeContainerViewModel,
        dataController: DataController
    ) {
        self.month = month
        self.containerViewModel = containerViewModel
        self.dataController = dataController
    }

    var balanceAngle: Double {
        let balancePercentage = totalIncome > 0 ?
        (totalBalance / totalIncome) :
        0
        return maxAngle * balancePercentage
    }

    var totalBalance: Double {
        return totalIncome - totalOutcome
    }

    var totalIncome: Double {
        return expenses.reduce(0) { $0 + ($1.expenseType == .income ? $1.amount : 0) }
    }

    var totalOutcome: Double {
        return expenses.reduce(0) { $0 + ($1.expenseType == .outcome ? $1.amount : 0) }
    }
}
