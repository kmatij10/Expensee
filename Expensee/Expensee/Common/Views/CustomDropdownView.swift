//
//  CustomDropdownView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import Foundation
import SwiftUI

struct DropdownOptionView: View {
    @Binding var shouldShowDropdown: Bool
    let value: String
    let key: String
    let action: (String) -> Void

    var body: some View {
        Button(action: {
            action(key)
            shouldShowDropdown = false
        }) {
            Text(value)
                .foregroundColor(.mainColor)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}

struct DropdownOptionsListView: View {
    @Binding var shouldShowDropdown: Bool
    let options: [DropdownOption]
    let action: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(options, id: \.self) { option in
                DropdownOptionView(
                    shouldShowDropdown: $shouldShowDropdown,
                    value: option.value,
                    key: option.key,
                    action: action
                )
            }
        }
        .padding(.vertical, 4)
        .background(Color.expenseeSecondaryColor)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.mainColor, lineWidth: 0)
        )
    }
}

struct DropdownButtonView: View {
    @Binding var shouldShowDropdown: Bool
    let displayText: String
    let options: [DropdownOption]
    let action: (String) -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                shouldShowDropdown.toggle()
            }) {
                HStack(spacing: 0) {
                    Text(displayText)
                        .foregroundColor(.mainColor)
                    Spacer()
                    Image(systemName: shouldShowDropdown ? "chevron.up" : "chevron.down")
                        .foregroundColor(.mainColor)
                }
            }
            .padding(.horizontal)
            .cornerRadius(4)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.expenseeSecondaryColor)
            )
            VStack(spacing: 0) {
                if shouldShowDropdown {
                    DropdownOptionsListView(
                        shouldShowDropdown: $shouldShowDropdown,
                        options: options,
                        action: action
                    )
                }
            }
        }
        .animation(.spring, value: shouldShowDropdown)
    }
}

struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
    let key: String
    let value: String
}
