//
//  HomeView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI
import Charts

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var showAddExpense = false
    @State private var showDetails = false
    @State private var expenseDetailsModel: ExpenseDataModel?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HomeHeaderView(
                    month: viewModel.month.monthName,
                    totalAmount: viewModel.totalBalance.formattedCurrency,
                    incomeAmount: viewModel.totalIncome.formattedCurrency,
                    outcomeAmount: viewModel.totalOutcome.formattedCurrency
                )
                ZStack {
                    ArcShape(end: viewModel.maxAngle, width: 10)
                        .fill(Color.gray.opacity(0.3))
                    ArcShape(end: viewModel.balanceAngle, width: 15)
                        .fill(Color.primaryButtonColor)
                    Text(viewModel.totalBalance.formattedCurrency)
                        .font(.title)
                        .foregroundColor(.mainColor)
                    }
                    .frame(width: 200, height: 200)
                PrimaryButtonView(title: "See monthly details") {
                    showDetails = true
                }
                HStack {
                    Text("Recent Transactions")
                        .font(.headline)
                        .foregroundColor(.mainColor)
                    Spacer(minLength: 30)
                    PrimaryButtonView(title: "Add transaction") {
                        showAddExpense = true
                    }
                }
                .padding(.vertical, 16)
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.expenses) { expense in
                        ExpenseView(
                            expense: expense,
                            action: {
                                expenseDetailsModel = expense
                                showAddExpense = true
                            },
                            deleteAction: {
                                viewModel.containerViewModel
                                    .deleteExpense(expense: expense)
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
                        dataController: viewModel.dataController
                    )
                    AddExpenseView(viewModel: model)
                }
            )
            .navigationDestination(
                isPresented: $showDetails,
                destination: {
                    let model = MonthDetailsViewModel(
                        dataController: viewModel.dataController,
                        expenses: viewModel.expenses,
                        month: viewModel.month
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
