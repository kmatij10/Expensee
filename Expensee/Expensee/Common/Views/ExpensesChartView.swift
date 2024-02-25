//
//  ExpensesChartView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import SwiftUI
import Charts

struct ExpensesChartView: View {
    var expensesByCategory: [ExpenseCategoryViewModel]

    var body: some View {
        Chart {
            ForEach(expensesByCategory, id: \.category) { expenseViewModel in
                BarMark(
                    x: .value("Category", expenseViewModel.category?.rawValue ?? "Other"),
                    y: .value("Total Amount", expenseViewModel.amount)
                )
                .foregroundStyle(by: .value("Category", expenseViewModel.category?.rawValue ?? "Other"))
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom)
        }
        .frame(height: 200)
    }
}
