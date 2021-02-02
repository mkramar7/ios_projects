//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 17.11.2020..
//

import SwiftUI

struct ContentView_old2: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    
    var body: some View {
        Text("Hello World")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        self.currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        self.finalAmount += self.currentAmount
                        self.currentAmount = 0
                    }
            )
    }
}
