//
//  Pie.swift
//  Memorize
//
//  Created by Dysson Vielmann on 6/7/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        // setting point at center
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        // setting radius
        let radius = min(rect.height, rect.width) / 2
        
        // setting starting point
        let start = CGPoint (
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise)
        p.addLine(to: center)
        
        return p
    }
}
