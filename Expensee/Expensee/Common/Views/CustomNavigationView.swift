//
//  CustomNavigationView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct CustomNavigationView: View {
    let title: String
    let hasBackButton: Bool
    let backButtonClick: () -> ()

    init(title: String, hasBackButton: Bool = true, backButtonClick: @escaping () -> Void) {
        self.title = title
        self.hasBackButton = hasBackButton
        self.backButtonClick = backButtonClick
    }

    var body: some View {
        ZStack {
            HStack {
                if hasBackButton {
                    Button(action: { backButtonClick() }) {
                        Image(systemName: "chevron.left")
                            .frame(width: 24)
                            .foregroundColor(.mainColor)
                    }
                }
                Spacer()
            }
            HStack {
                Text(title)
            }
        }
        .padding(.top, 66)
    }
}
