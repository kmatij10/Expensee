//
//  RootView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct RootView: View {
    var dataController: DataController

    var body: some View {
        NavigationStack {
            HomeContainerView(viewModel: HomeContainerViewModel(dataController: dataController))
        }
    }
}
