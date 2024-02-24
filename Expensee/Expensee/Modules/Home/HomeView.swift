//
//  HomeView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\ExpenseDataModel.createdAt, order: .reverse)]
    ) var expenses: FetchedResults<ExpenseDataModel>

    @State private var showAddExpense = false

    var body: some View {
        VStack(spacing: 10) {
            CustomNavigationView(
                title: "Add expense",
                backButtonClick: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            ScrollView {
                VStack(spacing: 16) {
                    HomeHeaderView(
                        totalAmount: "3.300",
                        income: "4.000",
                        outcome: "300"
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
                    ForEach(expenses) { expense in
                        ExpenseTransactionView(expense: expense)
                    }
                    Spacer()
                }
                .navigationDestination(
                    isPresented: $showAddExpense,
                    destination: {
                        let model = AddExpenseViewModel(expenseModel: nil)
                        AddExpense(viewModel: model)
                    }
                )
                .frame(maxWidth: .infinity)
                .cornerRadius(4)
            }
        }
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
    }
}

struct ExpenseTransactionView: View {
    @ObservedObject var expense: ExpenseDataModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(expense.category ?? "")
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text("\(expense.amount)")
                        .foregroundColor(.mainColor)
                }
                HStack {
                    Text(expense.subtitle ?? "")
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text(expense.category ?? "")
                        .foregroundColor(.mainColor)
                }
            }.padding(.leading, 4)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.secondaryColor)
        .cornerRadius(4)
    }
}

struct HomeHeaderView: View {
    let totalAmount: String
    let income: String
    let outcome: String

    var body: some View {
        VStack(spacing: 8) {
            Text("Total balance")
                .font(.headline)
                .foregroundColor(.mainColor)
            Text(totalAmount)
                .foregroundColor(.mainColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(Color.secondaryColor)
        .cornerRadius(4)
        HStack(spacing: 8) {
            VStack(spacing: 8) {
                Text("Income")
                    .font(.headline)
                    .foregroundColor(.mainColor)
                Text(income)
                    .foregroundColor(.mainColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.secondaryColor)
            .cornerRadius(4)
            VStack(spacing: 8) {
                Text("Outcome")
                    .font(.headline)
                    .foregroundColor(.mainColor)
                Text(outcome)
                    .foregroundColor(.mainColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.secondaryColor)
            .cornerRadius(4)
        }
    }
}
