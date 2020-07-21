//
//  Shapes.swift
//  Drawing
//
//  Created by Benjamin Keys on 5/18/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI

struct Triagnle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}


struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insertAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let modifiedStart = startAngle - Angle.degrees(90)
        let modifiedEnd = endAngle - Angle.degrees(90)
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insertAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insertAmount += amount
        return arc
    }
}
