//
//  ExpenseView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

struct ExpenseView: View {
    let expense: ExpenseDataModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(expense.expenseCategory?.text ?? "")
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text(expense.amount.formattedCurrency)
                        .foregroundColor(.mainColor)
                }
                HStack {
                    Text(expense.subtitle ?? "")
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text(expense.createdAt?.formattedDate ?? "")
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
