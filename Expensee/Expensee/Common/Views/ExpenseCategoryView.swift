//
//  ExpenseCategoryView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

struct ExpenseCategoryView: View {
    let viewModel: ExpenseCategoryViewModel

    var body: some View {
        HStack (spacing: 0){
            VStack(alignment: .leading, spacing: 25) {
                HStack(spacing: 0) {
                    Text(viewModel.category?.text ?? "")
                        .font(.headline)
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text(viewModel.amount.formattedCurrency)
                }
                HStack(spacing: 10) {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(viewModel.largeAmount ? .redPrimaryColor : .greenPrimaryColor)
                    Text(
                        Constants.thresholdForCategory(
                            viewModel.threshold.formattedCurrency
                        )
                    )
                    .font(.headline)
                    .foregroundColor(.mainColor)
                    Spacer()
                }
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(.gray.opacity(0.3))
                            .cornerRadius(1)
                        Rectangle()
                            .frame(width: currentAmountLineWidth(for: geometry.size.width), height: 6)
                            .foregroundColor(.primaryButtonColor)
                            .cornerRadius(2)
                    }
                }
                .frame(height: 20)
            }.padding(.leading, 4)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 30)
        .padding(.bottom, 10)
        .padding(.horizontal, 14)
        .background(Color.expenseeSecondaryColor)
        .cornerRadius(4)
    }

    private func currentAmountLineWidth(for totalWidth: CGFloat) -> CGFloat {
        let ratio = min(viewModel.amount / viewModel.threshold, 1)
        return totalWidth * CGFloat(ratio)
    }
}

struct ExpenseCategoryViewModel {
    let category: ExpenseCategory?
    let amount: Double
    let largeAmount: Bool
    let threshold: Double
}
