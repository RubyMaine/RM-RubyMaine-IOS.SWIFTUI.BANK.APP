//
//  Expense.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI

struct Expense: Identifiable {
    let id = UUID().uuidString
    let amountSpent: String
    let product: String
    let productIcon: String
    let spendType: String
}
