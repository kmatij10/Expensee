//
//  NavigationRouter.swift
//  Expensee
//
//  Created by Kristina Matijasic on 28.08.2024..
//

import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    
    @Published var routes = [Route]()
        
    func push(to screen: Route) {
        guard !routes.contains(screen) else {
            return
        }
        routes.append(screen)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func pop(count: Int) {
        routes.removeLast(count)
    }
}
