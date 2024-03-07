//
//  CategoryThresholdView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import SwiftUI

struct CategoryThresholdView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: CategoryThresholdViewModel

    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationView(
                title: Constants.categoryThreshold,
                backButtonClick: {
                    presentationMode.wrappedValue.dismiss()
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
                                placeholderText: Constants.amount
                            )
                        }
                    }
                    PrimaryButtonView(title: Constants.save) {
                        viewModel.saveThresholds()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 44)
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
        .navigationBarHidden(true)
    }
}
