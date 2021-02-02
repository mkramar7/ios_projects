//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 17.11.2020..
//

import SwiftUI

struct ContentView_old3: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var body: some View {
        Text("Hello World")
            .rotationEffect(finalAmount + currentAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        self.currentAmount = angle
                    }
                    .onEnded { amount in
                        self.finalAmount += self.currentAmount
                        self.currentAmount = .degrees(0)
                    }
            )
    }
}
