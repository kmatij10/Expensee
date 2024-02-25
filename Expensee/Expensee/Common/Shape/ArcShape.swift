//
//  ArcShape.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation
import SwiftUI

struct ArcShape: Shape {
    var start: Double = 0
    var end: Double = 270
    var width: Double = 15

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startValue = start + 135

        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2,
            startAngle: .degrees(startValue.truncatingRemainder(dividingBy: 360)),
            endAngle: .degrees((startValue + end).truncatingRemainder(dividingBy: 360)),
            clockwise: false
        )

        return path.strokedPath(.init(lineWidth: width, lineCap:  .round))
    }
}
