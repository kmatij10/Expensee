//
//  AddExpenseView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct AddExpenseView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @StateObject var viewModel: AddExpenseViewModel
    @State var showTypeDropdown = false
    @State var showCategoryDropdown = false

    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationView(
                title: viewModel.titleText,
                backButtonClick: {
                    navigationRouter.pop()
                }
            )
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    DropdownButtonView(
                        shouldShowDropdown: $showTypeDropdown,
                        displayText: viewModel.typeDisplayText,
                        options: viewModel.typeOptions
                    ) { selectedOption in
                        if let selectedType = ExpenseType(rawValue: selectedOption) {
                            viewModel.type = selectedType
                        }
                    }
                    DropdownButtonView(
                        shouldShowDropdown: $showCategoryDropdown,
                        displayText: viewModel.categoryDisplayText,
                        options: viewModel.categoryOptions
                    ) { selectedOption in
                        if let selectedCategory = ExpenseCategory(rawValue: selectedOption) {
                            viewModel.category = selectedCategory
                        }
                    }
                    CustomTextFieldView(
                        text: $viewModel.amount,
                        placeholderText: Constants.amount,
                        keyboardType: .decimalPad
                    )
                    CustomTextFieldView(
                        text: $viewModel.subtitle,
                        placeholderText: Constants.description,
                        keyboardType: .alphabet
                    )
                    HStack(spacing: 0) {
                        DatePicker(
                            Constants.date,
                            selection: $viewModel.createdAt,
                            displayedComponents: [.date]
                        )
                        .labelsHidden()
                        .padding(.leading, 16)
                        Spacer()
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .accentColor(Color.mainColor)
                    .background(Color.expenseeSecondaryColor)
                    .cornerRadius(4)
                    PrimaryButtonView(title: viewModel.titleText) {
                        viewModel.saveExpense()
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 44)
        .edgesIgnoringSafeArea(.all)
        .background(Color.expenseePrimaryColor)
        .navigationBarHidden(true)
        .scrollDismissesKeyboard(.immediately)
        .errorAlert(
            isPresented: $viewModel.showErrorAlert,
            title: viewModel.alertTitle,
            message: viewModel.alertMessage
        )
        .onReceive(viewModel.$saveSuccessful) { close in
            if close { navigationRouter.pop() }
        }
    }
}
