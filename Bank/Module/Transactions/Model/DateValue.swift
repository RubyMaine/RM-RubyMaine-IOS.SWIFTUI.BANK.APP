//
//  DateValue.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import Foundation

struct DateValue: Identifiable {
    let id = UUID().uuidString
    let day: Int
    let date: Date
}
