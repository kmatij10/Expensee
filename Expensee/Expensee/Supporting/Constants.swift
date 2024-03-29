//
//  Constants.swift
//  Expensee
//
//  Created by Kristina Matijasic on 03.03.2024..
//

import Foundation

enum Constants {

    static let currencyCode = "EUR"
    static let currencySymbol = "€"
    static let currencyDefault = "€0.00"
    static let dateFormat = "yyyy-MM-dd"

    static let thresholdDefault = 100.0

    static let januaryString = "January"
    static let februaryString = "February"
    static let marchString = "March"
    static let aprilString = "April"
    static let mayString = "May"
    static let juneString = "June"
    static let julyString = "July"
    static let augustString = "August"
    static let septemberString = "September"
    static let octoberString = "October"
    static let novemberString = "November"
    static let decemberString = "December"

    static let unknownString = "Unknown"

    static let edit = "Edit"
    static let delete = "Delete"
    static let ok = "OK"
    static let cancel = "Cancel"
    static let save = "Save"

    static let category = "Category"
    static let totalAmount = "Total Amount"
    static let categoryThreshold = "Category Threshold"

    static let paycheck = "Paycheck"
    static let food = "Food"
    static let drinks = "Drinks"
    static let car = "Car"
    static let bills = "Bills"
    static let other = "Other"
    static let snacks = "Snacks"
    static let cosmetics = "Cosmetics"
    static let glutenFree = "Gluten Free"
    static let sport = "Sport"
    static let delivery = "Delivery"
    static let streaming = "Streaming"
    static let gas = "Gas"
    static let credit = "Credit"
    static let education = "Education"
    static let health = "Health"
    static let cigarettes = "Cigarettes"
    static let household = "Household"
    static let hobbies = "Hobbies"
    static let clothing = "Clothing"
    static let repairs = "Repairs"
    static let installments = "Installments"
    static let greenMarket = "Green Market"
    static let supplements = "Supplements"
    static let beauty = "Beauty"

    static let income = "Income"
    static let outcome = "Outcome"

    static let monthlyDetails = "Monthly details"
    static let home = "Home"
    static let monthlyDetailsAction = "See monthly outcome details"
    static let recentTransactions = "Recent Transactions"
    static let addTransactionAction = "Add transaction"
    static let updateTransactionAction = "Update transaction"

    static let amount = "Amount"
    static let description = "Description"
    static let date = "Date"

    static let expenseModel = "ExpenseModel"

    static let oops = "Oops!"
    static let unexpectedError = "An unexpected error occurred."

    static let confirmDelete = "Confirm Delete"
    static let confirmDeleteMessage = "Are you sure you want to delete this item?"
    static let setThreshold = "Set Category Thresholds"

    static func thresholdForCategory(_ threshold: String) -> String {
        "Threshold: \(threshold)"
    }

    static func totalBalanceForMonth(_ month: String) -> String {
        "Total balance for \(month)"
    }

    static func failedToLoadData(_ error: Error) -> String {
        "Failed to load data: \(error.localizedDescription)"
    }

    static func somethingWentWrong(_ error: Error) -> String {
        "Something went wrong: \(error.localizedDescription)"
    }

    static func errorFetchingData(_ error: Error) -> String {
        "Error fetching data: \(error.localizedDescription)"
    }
}
