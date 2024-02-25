//
//  ExpensesChartView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import SwiftUI
import Charts

struct ExpensesChartView: View {
    var expenses: [ExpenseDataModel]

    var body: some View {
        let expensesByCategory = expensesByCategory(expenses: expenses)
        Chart {
            ForEach(expensesByCategory.keys.sorted(), id: \.self) { category in
                if let totalAmount = expensesByCategory[category] {
                    BarMark(
                        x: .value("Category", category),
                        y: .value("Total Amount", totalAmount)
                    )
                    .foregroundStyle(by: .value("Category", category))
                }
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom)
        }
        .frame(height: 200)
    }
}

private extension ExpensesChartView {

    func expensesByCategory(expenses: [ExpenseDataModel]) -> [String: Double] {
        let groupedExpenses = Dictionary(grouping: expenses, by: { $0.expenseCategory?.text })
        let summedExpenses = groupedExpenses.compactMapKeys { $0 }.mapValues { $0.reduce(0) { $0 + $1.amount } }
        return summedExpenses
    }
}
