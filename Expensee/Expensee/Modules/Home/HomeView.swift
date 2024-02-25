//
//  HomeView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI
import Charts

struct HomeView: View {
    let month: Int
    let expenses: [ExpenseDataModel]
    let dataController: DataController

    @State private var showAddExpense = false
    @State private var showDetails = false
    @State private var expenseDetailsModel: ExpenseDataModel?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HomeHeaderView(
                    month: month.monthName,
                    totalAmount: totalBalance(expenses: expenses).formattedCurrency,
                    incomeAmount: totalIncome(expenses: expenses).formattedCurrency,
                    outcomeAmount: totalOutcome(expenses: expenses).formattedCurrency
                )
                ExpensesChartView(expenses: expenses)
                PrimaryButtonView(title: "See monthly details") {
                    showDetails = true
                }
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
                        ExpenseView(
                            expense: expense,
                            action: {
                                expenseDetailsModel = expense
                                showAddExpense = true
                            }
                        )
                    }
                }
                Spacer()
            }
            .navigationDestination(
                isPresented: $showAddExpense,
                destination: {
                    let model = AddExpenseViewModel(
                        expenseModel: expenseDetailsModel,
                        dataController: dataController
                    )
                    AddExpenseView(viewModel: model)
                }
            )
            .navigationDestination(
                isPresented: $showDetails,
                destination: {
                    let model = MonthDetailsViewModel(
                        dataController: dataController,
                        expenses: expenses,
                        month: month
                    )
                    MonthDetailsView(viewModel: model)
                }
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(4)
        }
        .padding(.horizontal, 24)
        .onAppear {
            expenseDetailsModel = nil
        }
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
}
