//
//  PrimaryButtonView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.mainColor)
            .frame(maxWidth: .infinity)
            .frame(height: 53)
            .background(Color.primaryButtonColor)
            .cornerRadius(14)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primaryButtonStyle: PrimaryButtonStyle { PrimaryButtonStyle() }
}

struct PrimaryButtonView: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
        }
        .buttonStyle(.primaryButtonStyle)
    }
}
