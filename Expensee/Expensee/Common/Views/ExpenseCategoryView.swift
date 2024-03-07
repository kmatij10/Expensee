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
            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 0) {
                    Text(viewModel.category?.text ?? "")
                        .font(.headline)
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text(viewModel.amount.formattedCurrency)
                }
                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(viewModel.largeAmount ? .redPrimaryColor : .greenPrimaryColor)
                    Spacer()
                }
            }.padding(.leading, 4)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .padding(.horizontal, 14)
        .background(Color.secondaryColor)
        .cornerRadius(4)
    }
}

struct ExpenseCategoryViewModel {
    let category: ExpenseCategory?
    let amount: Double
    let largeAmount: Bool
}
