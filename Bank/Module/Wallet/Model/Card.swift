//
//  Card.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import struct SwiftUI.UUID

struct Card: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
}
