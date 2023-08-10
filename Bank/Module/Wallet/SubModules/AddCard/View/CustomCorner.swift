//
//  CustomCorner.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

import SwiftUI

struct CustomCorner: Shape {
    let corners: UIRectCorner
    let radius: CGFloat

    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
