//
//  ConfirmationAlertModifier.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import SwiftUI

struct ConfirmationAlertModifier<Item>: ViewModifier where Item: Identifiable {
    @Binding var isPresented: Bool
    @Binding var itemToDelete: Item?
    let title: String
    let message: String
    let deleteAction: (Item) -> Void

    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                Button(Constants.delete, role: .destructive) {
                    if let item = itemToDelete {
                        deleteAction(item)
                        itemToDelete = nil
                    }
                }
                Button(Constants.cancel, role: .cancel) {
                    isPresented = false
                    itemToDelete = nil
                }
            } message: {
                Text(message)
            }
    }
}

extension View {
    func confirmationAlert<Item>(
        isPresented: Binding<Bool>,
        itemToDelete: Binding<Item?>,
        title: String,
        message: String,
        deleteAction: @escaping (Item) -> Void
    ) -> some View where Item: Identifiable {
        self.modifier(
            ConfirmationAlertModifier(
                isPresented: isPresented, 
                itemToDelete: itemToDelete,
                title: title,
                message: message,
                deleteAction: deleteAction
            )
        )
    }
}
