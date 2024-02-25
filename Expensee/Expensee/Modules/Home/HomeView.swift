//
//  HomeView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct HomeView: View {
    let month: Int
    let expenses: [ExpenseDataModel]
    let dataController: DataController

    @State private var showAddExpense = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HomeHeaderView(
                    month: getMonthName(from: month),
                    totalAmount: totalBalance(expenses: expenses).formattedCurrency,
                    incomeAmount: totalIncome(expenses: expenses).formattedCurrency,
                    outcomeAmount: totalOutcome(expenses: expenses).formattedCurrency
                )
                PrimaryButtonView(title: "Add transaction") {
                    showAddExpense = true
                }
                HStack {
                    Text("Recent Transaction")
                        .font(.headline)
                        .foregroundColor(.mainColor)
                    Spacer()
                }
                .padding(8)
                LazyVStack(spacing: 8) {
                    ForEach(expenses) { expense in
                        ExpenseView(expense: expense)
                    }
                }
                Spacer()
            }
            .navigationDestination(
                isPresented: $showAddExpense,
                destination: {
                    let model = AddExpenseViewModel(expenseModel: nil, dataController: dataController)
                    AddExpense(viewModel: model)
                }
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(4)
        }
        .padding(.horizontal, 24)
    }
}

private extension HomeView {

    func totalBalance(expenses: [ExpenseDataModel]) -> Double {
        let totalIncome = totalIncome(expenses: expenses)
        let totalOutcome = totalOutcome(expenses: expenses)
        return totalIncome - totalOutcome
    }

    func totalIncome(expenses: [ExpenseDataModel]) -> Double {
        return expenses.reduce(0) { $0 + ($1.expenseType == .income ? $1.amount : 0) }
    }

    func totalOutcome(expenses: [ExpenseDataModel]) -> Double {
        return expenses.reduce(0) { $0 + ($1.expenseType == .outcome ? $1.amount : 0) }
    }

    func getMonthName(from monthNumber: Int) -> String {
        let months = [
            1: "January",
            2: "February",
            3: "March",
            4: "April",
            5: "May",
            6: "June",
            7: "July",
            8: "August",
            9: "September",
            10: "October",
            11: "November",
            12: "December"
        ]
        return months[monthNumber] ?? "Unknown"
    }
}
