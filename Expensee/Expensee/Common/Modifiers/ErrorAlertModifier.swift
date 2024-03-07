//
//  ErrorAlertView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var title: String
    var message: String

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text(Constants.ok))
                )
            }
    }
}

extension View {

    func errorAlert(isPresented: Binding<Bool>, title: String, message: String) -> some View {
        self.modifier(ErrorAlertModifier(isPresented: isPresented, title: title, message: message))
    }
}
