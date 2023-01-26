//
//  Diamond.swift
//  login_transition
//
//  Created by Victor Miranda on 26/01/23.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY - 70))
        path.addLine(to: CGPoint(x: rect.maxX - 20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + 20, y: rect.midY))
        path.closeSubpath()

        return path
    }
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX - 15, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}
