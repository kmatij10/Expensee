//
//  DateExtension.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation

extension Date {

    var formattedDate: String {
        let format: String = Constants.dateFormat
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
