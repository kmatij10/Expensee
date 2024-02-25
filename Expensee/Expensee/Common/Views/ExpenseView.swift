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
    let action: () -> Void
    let deleteAction: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(expense.expenseCategory?.text ?? "")
                        .font(.headline)
                        .foregroundColor(.mainColor)
                    Spacer()
                    Text(expense.amount.formattedCurrency)
                        .foregroundColor(expense.expenseType == .income ? 
                            .greenPrimaryColor :
                            .redPrimaryColor
                        )
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
        .onTapGesture {
            action()
        }
        .contextMenu {
            Button(action: action) {
                Label("Edit", systemImage: "pencil")
            }
            Button(action: deleteAction) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
