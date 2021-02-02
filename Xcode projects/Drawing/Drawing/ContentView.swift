//
//  ContentView.swift
//  Drawing
//
//  Created by Marko Kramar on 09/09/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct Arrow: Shape {
    var lineThickness: CGFloat
    
    var animatableData: CGFloat {
        get {
            lineThickness
        }
        
        set {
            self.lineThickness = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Triangle part
        path.move(to: CGPoint(x: rect.midX, y: rect.minY / 2))
        path.addLine(to: CGPoint(x: rect.minX + 50, y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.maxX - 50, y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY / 2))
        
        // Rectangle part
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY / 2))
        path.addRect(CGRect(x: rect.midX - (lineThickness / 2), y: rect.maxY / 2, width: lineThickness, height: 200))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: amount)
                .frame(width: 300, height: 300)
            Slider(value: $amount)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
