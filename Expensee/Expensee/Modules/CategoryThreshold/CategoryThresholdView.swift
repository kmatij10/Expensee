//
//  CategoryThresholdView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import SwiftUI

struct CategoryThresholdView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject var viewModel: CategoryThresholdViewModel

    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationView(
                title: Constants.categoryThreshold,
                backButtonClick: {
                    navigationRouter.pop()
                }
            )
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(category.text)
                                .font(.headline)
                                .foregroundColor(.mainColor)
                            CustomTextFieldView(
                                text: Binding<String>(
                                    get: { viewModel.thresholds[category, default: String(Constants.thresholdDefault)] },
                                    set: { viewModel.thresholds[category] = $0 }
                                ),
                                placeholderText: Constants.amount,
                                keyboardType: .decimalPad
                            )
                        }
                    }
                    PrimaryButtonView(title: Constants.save) {
                        viewModel.saveThresholds()
                        navigationRouter.pop()
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
    }
}
