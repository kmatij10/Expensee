//
//  ExpenseeApp.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

@main
struct ExpenseeApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.colorScheme, .dark)
        }
    }
}
