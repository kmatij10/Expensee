//
//  EmptyStateView.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import SwiftUI
import Lottie

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Nothing to see here")
                .font(.headline)
                .foregroundColor(.mainColor)
            LottieView(animation: .named("empty"))
              .playing(loopMode: .loop)
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 24)
    }
}
