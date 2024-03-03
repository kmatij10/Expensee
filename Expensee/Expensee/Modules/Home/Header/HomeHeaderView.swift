//
//  HomeHeaderView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import SwiftUI

struct HomeHeaderView: View {
    let month: String
    let totalAmount: String
    let incomeAmount: String
    let outcomeAmount: String

    var body: some View {
        VStack(spacing: 8) {
            Text(Constants.totalBalanceForMonth(month))
                .font(.headline)
                .foregroundColor(.mainColor)
            Text(totalAmount)
                .foregroundColor(.mainColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(Color.secondaryColor)
        .cornerRadius(4)
        HStack(spacing: 8) {
            VStack(spacing: 8) {
                Text(Constants.income)
                    .font(.headline)
                    .foregroundColor(.mainColor)
                Text(incomeAmount)
                    .foregroundColor(.greenPrimaryColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.secondaryColor)
            .cornerRadius(4)
            VStack(spacing: 8) {
                Text(Constants.outcome)
                    .font(.headline)
                    .foregroundColor(.mainColor)
                Text(outcomeAmount)
                    .foregroundColor(.redPrimaryColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.secondaryColor)
            .cornerRadius(4)
        }
    }
}
