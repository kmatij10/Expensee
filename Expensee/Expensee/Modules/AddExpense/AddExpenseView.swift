//
//  AddExpenseView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: AddExpenseViewModel
    @State var showTypeDropdown = false
    @State var showCategoryDropdown = false

    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationView(
                title: viewModel.titleText,
                backButtonClick: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
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
            CustomTextFieldView(text: $viewModel.amount, placeholderText: Constants.amount)
            CustomTextFieldView(text: $viewModel.subtitle, placeholderText: Constants.description)
            HStack {
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
            .background(Color.secondaryColor)
            .cornerRadius(4)
            PrimaryButtonView(title: viewModel.titleText) {
                viewModel.saveExpense()
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
        .navigationBarHidden(true)
        .onReceive(viewModel.$saveSuccessful) { close in
            if close { presentationMode.wrappedValue.dismiss() }
        }
    }
}
