//
//  CustomNavigationView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct CustomNavigationView: View {
    let title: String
    let hasBackButton: Bool = true
    let backButtonClick: () -> ()

    var body: some View {
        ZStack {
            HStack {
                if hasBackButton {
                    Button(action: { backButtonClick() }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                Spacer()
            }
            HStack {
                Text(title)
                if !hasBackButton { Spacer() }
            }
        }
        .padding(.top, 66)
    }
}
