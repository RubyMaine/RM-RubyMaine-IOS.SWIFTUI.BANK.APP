//
//  User.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID().uuidString
    let name: String
    let image: String
    let type: String
    let amount: String
    let color: Color
}
