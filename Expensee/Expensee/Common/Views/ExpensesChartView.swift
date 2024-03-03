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
                    x: .value(Constants.category, expenseViewModel.category?.rawValue ?? Constants.other),
                    y: .value(Constants.totalAmount, expenseViewModel.amount)
                )
                .foregroundStyle(by: .value(Constants.category, expenseViewModel.category?.rawValue ?? Constants.other))
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom)
        }
        .frame(height: 200)
    }
}
