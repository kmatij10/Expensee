//
//  HomeContainerView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

struct HomeContainerView: View {
    @StateObject var viewModel: HomeContainerViewModel

    var body: some View {
        VStack(spacing: 10) {
            CustomNavigationView(title: Constants.home)
            TabView {
                ForEach(1...12, id: \.self) { month in
                    let model = HomeViewModel(
                        month: month,
                        containerViewModel: viewModel,
                        dataController: viewModel.dataController
                    )
                    HomeView(viewModel: model)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.primaryColor)
    }
}
