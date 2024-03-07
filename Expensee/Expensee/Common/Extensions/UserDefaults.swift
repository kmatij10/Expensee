//
//  UserDefaults.swift
//  Expensee
//
//  Created by Kristina Matijasic on 07.03.2024..
//

import Foundation
import Combine

extension UserDefaults {

    func setLargeAmountThreshold(for category: ExpenseCategory, amount: Double) {
        var thresholds = getLargeAmountThresholds()
        thresholds[category.rawValue] = amount
        set(thresholds, forKey: Keys.largeAmountThresholds)
        NotificationCenter
            .default
            .post(name: UserDefaults.didChangeNotification, object: nil, userInfo: [Keys.largeAmountThresholds: thresholds]
            )
    }

    func getLargeAmountThreshold(for category: ExpenseCategory) -> Double? {
        let thresholds = getLargeAmountThresholds()
        return thresholds[category.rawValue]
    }

    var largeAmountThresholdsPublisher: AnyPublisher<[String: Double], Never> {
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification, object: nil)
            .compactMap { notification -> [String: Double]? in
                notification.userInfo?[Keys.largeAmountThresholds] as? [String: Double]
            }
            .prepend(getLargeAmountThresholds())
            .eraseToAnyPublisher()
    }
}

private extension UserDefaults {

    enum Keys {
        static let largeAmountThresholds = "largeAmountThresholds"
    }

    func getLargeAmountThresholds() -> [String: Double] {
        (object(forKey: Keys.largeAmountThresholds) as? [String: Double]) ?? [:]
    }
}
