//
//  MonthDetailsView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import SwiftUI

struct MonthDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var showCategoryThreshold = false
    var viewModel: MonthDetailsViewModel

    var body: some View {
        VStack(spacing: 10) {
            CustomNavigationView(
                title: Constants.monthlyDetails,
                backButtonClick: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            ScrollView {
                VStack(spacing: 15) {
                    ExpensesChartView(expensesByCategory: viewModel.expensesByCategory)
                    PrimaryButtonView(title: Constants.setThreshold) {
                        showCategoryThreshold = true
                    }
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.expensesByCategory, id: \.category) { expenseByCategory in
                            ExpenseCategoryView(viewModel: expenseByCategory)
                        }
                    }
                }
                .padding(.top, 15)
            }
        }
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
        .navigationBarHidden(true)
        .navigationDestination(
            isPresented: $showCategoryThreshold,
            destination: {
                let model = CategoryThresholdViewModel()
                CategoryThresholdView(viewModel: model)
            }
        )
    }
}
