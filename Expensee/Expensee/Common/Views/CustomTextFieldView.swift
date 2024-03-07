//
//  CustomTextFieldView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import SwiftUI

struct CustomTextFieldView: View {
    @Binding var text: String
    let placeholderText: String
    let keyboardType: UIKeyboardType

    var body: some View {
        HStack(spacing: 8) {
            Text(placeholderText)
                .font(.headline)
                .padding(.leading, 16)
            TextField("", text: $text)
        }
        .frame(height: 50).frame(maxWidth: .infinity)
        .accentColor(Color.mainColor)
        .background(Color.secondaryColor)
        .cornerRadius(4)
        .keyboardType(keyboardType)
    }
}
