//
//  DictionaryExtension.swift
//  Expensee
//
//  Created by Kristina Matijasic on 25.02.2024..
//

import Foundation

extension Dictionary {
    
    func compactMapKeys<T>(_ transform: (Key) throws -> T?) rethrows -> [T: Value] {
        var newDictionary: [T: Value] = [:]
        for (key, value) in self {
            if let newKey = try transform(key) {
                newDictionary[newKey] = value
            }
        }
        return newDictionary
    }
}
