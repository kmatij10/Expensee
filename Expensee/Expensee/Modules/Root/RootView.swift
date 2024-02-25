//
//  RootView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 24.02.2024..
//

import SwiftUI

struct RootView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var dataController: DataController

    var body: some View {
        NavigationStack {
            HomeContainerView(dataController: dataController)
        }
    }
}
