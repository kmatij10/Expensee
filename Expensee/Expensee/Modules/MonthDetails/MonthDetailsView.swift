//
//  MonthDetailsView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import SwiftUI

struct MonthDetailsView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @State private var showCategoryThreshold = false
    var viewModel: MonthDetailsViewModel

    var body: some View {
        VStack(spacing: 10) {
            CustomNavigationView(
                title: Constants.monthlyDetails,
                backButtonClick: {
                    navigationRouter.pop()
                }
            )
            Group {
                if viewModel.expensesByCategory.isEmpty {
                    EmptyStateView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 15) {
                            ExpensesChartView(expensesByCategory: viewModel.expensesByCategory)
                            PrimaryButtonView(title: Constants.setThreshold) {
                                navigationRouter.push(to: .categoryThreshold)
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
            }
        }
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.all)
        .background(Color.expenseePrimaryColor)
        .navigationBarHidden(true)
    }
}
