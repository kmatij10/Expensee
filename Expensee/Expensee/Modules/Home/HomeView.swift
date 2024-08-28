//
//  HomeView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI
import Charts

struct HomeView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @StateObject var viewModel: HomeViewModel
    @State private var expenseDetailsModel: ExpenseDataModel?
    @State private var showingDeleteConfirmation = false

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
                PrimaryButtonView(title: Constants.monthlyDetailsAction) {
                    navigationRouter.push(to: 
                            .monthDetails(
                                dataController: viewModel.dataController,
                                expenses: viewModel.expenses,
                                month: viewModel.month
                            )
                    )
                }
                HStack(spacing: 0) {
                    Text(Constants.recentTransactions)
                        .font(.headline)
                        .foregroundColor(.mainColor)
                    Spacer(minLength: 30)
                    PrimaryButtonView(title: Constants.addTransactionAction) {
                        navigationRouter.push(to: 
                                .addExpense(
                                    expenseModel: expenseDetailsModel,
                                    dataController: viewModel.dataController
                                )
                        )
                    }
                }
                .padding(.vertical, 16)
                Group {
                    if viewModel.expenses.isEmpty {
                        EmptyStateView()
                    } else {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.expenses) { expense in
                                ExpenseView(
                                    expense: expense,
                                    action: {
                                        expenseDetailsModel = expense
                                        navigationRouter.push(to: 
                                                .addExpense(
                                                    expenseModel: expenseDetailsModel,
                                                    dataController: viewModel.dataController
                                                )
                                        )
                                    },
                                    deleteAction: {
                                        expenseDetailsModel = expense
                                        showingDeleteConfirmation = true
                                    }
                                )
                            }
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(4)
        }
        .padding(.horizontal, 24)
        .confirmationAlert(
            isPresented: $showingDeleteConfirmation,
            itemToDelete: $expenseDetailsModel,
            title: Constants.confirmDelete,
            message: Constants.confirmDeleteMessage,
            deleteAction: { item in
                viewModel.containerViewModel.deleteExpense(expense: item)
            }
        )
        .errorAlert(
            isPresented: $viewModel.containerViewModel.showErrorAlert,
            title: viewModel.alertTitle,
            message: viewModel.alertMessage
        )
        .onAppear {
            expenseDetailsModel = nil
        }
    }
}
