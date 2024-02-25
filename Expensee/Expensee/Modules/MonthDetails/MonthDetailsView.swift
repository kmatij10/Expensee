//
//  MonthDetailsView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import SwiftUI

struct MonthDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var viewModel: MonthDetailsViewModel

    var body: some View {
        VStack(spacing: 10) {
            CustomNavigationView(
                title: "Monthly details",
                backButtonClick: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.expensesByCategory, id: \.category) { expenseByCategory in
                        ExpenseCategoryView(viewModel: expenseByCategory)
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
        .navigationBarHidden(true)
    }
}
