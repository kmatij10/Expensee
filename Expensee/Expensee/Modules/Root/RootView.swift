//
//  RootView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct RootView: View {
    var dataController: DataController
    @StateObject private var navigationRouter = NavigationRouter()

    var body: some View {
        NavigationStack(path: $navigationRouter.routes) {
            HomeContainerView(viewModel: HomeContainerViewModel(dataController: dataController))
                .navigationDestination(for: Route.self) { $0 }
        }
        .environmentObject(navigationRouter)
    }
}
