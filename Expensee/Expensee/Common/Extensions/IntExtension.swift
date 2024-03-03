//
//  IntExtension.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation

extension Int {

    var monthName: String {
        let months = [
            1: Constants.januaryString,
            2: Constants.februaryString,
            3: Constants.marchString,
            4: Constants.aprilString,
            5: Constants.mayString,
            6: Constants.juneString,
            7: Constants.julyString,
            8: Constants.augustString,
            9: Constants.septemberString,
            10: Constants.octoberString,
            11: Constants.novemberString,
            12: Constants.decemberString
        ]
        return months[self] ?? Constants.unknownString
    }
}
