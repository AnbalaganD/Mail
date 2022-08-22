//
//  PolygonShape.swift
//  Mail (iOS)
//
//  Created by Anbalagan D on 08/01/21.
//

import SwiftUI

struct PolygonShape: Shape {
    
    var sides: Int
    
    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            print(angle)
            // Calculate vertex position
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            print(pt)
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}



struct ShapeView: View {
    var body: some View {
        PolygonShape(sides: 5)
            .stroke(Color.red, lineWidth: 3)
            .padding()
    }
}

struct PolygonShape_Previews: PreviewProvider {
    static var previews: some View {
        ShapeView()
    }
}
