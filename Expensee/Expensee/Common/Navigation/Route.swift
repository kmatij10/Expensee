//
//  Route.swift
//  Expensee
//
//  Created by Kristina Matijasic on 28.08.2024..
//

import Foundation
import SwiftUI

enum Route {
    case addExpense(expenseModel: ExpenseDataModel?, dataController: DataController)
    case monthDetails(dataController: DataController, expenses: [ExpenseDataModel], month: Int)
    case categoryThreshold
}

extension Route: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.addExpense(let lhsItem, _), .addExpense(let rhsItem, _)):
            return lhsItem == rhsItem
        case (.monthDetails(_, let lhsExpenses, let lhsMonth), .monthDetails(_, let rhsExpenses, let rhsMonth)):
            return lhsExpenses == rhsExpenses && lhsMonth == rhsMonth
        case (.categoryThreshold, .categoryThreshold):
            return true
        default:
            return false
        }
    }
}

extension Route: View {
    
    var body: some View {
        switch self {
        case .addExpense(let expenseModel, let dataController):
            let model = AddExpenseViewModel(
                expenseModel: expenseModel,
                dataController: dataController
            )
            AddExpenseView(viewModel: model)
        case .monthDetails(let dataController, let expenses, let month):
            let model = MonthDetailsViewModel(
                dataController: dataController,
                expenses: expenses,
                month: month
            )
            MonthDetailsView(viewModel: model)
        case .categoryThreshold:
            let model = CategoryThresholdViewModel()
            CategoryThresholdView(viewModel: model)
        }
    }
}
