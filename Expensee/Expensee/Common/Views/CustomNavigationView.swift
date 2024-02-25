//
//  CustomNavigationView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct CustomNavigationView: View {
    let title: String
    let backButtonClick: (() -> Void)?

    init(title: String, backButtonClick: (() -> Void)? = nil) {
        self.title = title
        self.backButtonClick = backButtonClick
    }

    var body: some View {
        ZStack {
            HStack {
                if let backButtonClick {
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
