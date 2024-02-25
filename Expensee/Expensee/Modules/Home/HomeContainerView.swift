//
//  HomeContainerView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

struct HomeContainerView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\ExpenseDataModel.createdAt, order: .reverse)]
    ) private var expenses: FetchedResults<ExpenseDataModel>
    let dataController: DataController

    var body: some View {
        VStack(spacing: 10) {
            CustomNavigationView(title: "Home")
            TabView {
                ForEach(1...12, id: \.self) { month in
                    HomeView(
                        month: month,
                        expenses: expensesByMonth(month: month),
                        dataController: dataController
                    )
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
    }
}

private extension HomeContainerView {

    func expensesByMonth(month: Int) -> [ExpenseDataModel] {
        return expenses.filter {
            let calendar = Calendar.current
            let expenseMonth = calendar.component(.month, from: $0.createdAt ?? Date())
            return month == expenseMonth
        }
    }
}
