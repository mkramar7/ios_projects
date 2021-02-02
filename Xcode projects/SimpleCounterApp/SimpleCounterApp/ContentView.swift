//
//  ContentView.swift
//  SimpleCounterApp
//
//  Created by Marko Kramar on 26.12.2020..
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        print("ContentView")
        return VStack {
            Button("Tap me!") { counter += 1 }
            LabelView(number: $counter)
        }
    }
}

struct LabelView: View {
    @Binding var number: Int
    
    var body: some View {
        print("LabelView")
        return Group {
            if number > 0 {
                Text("You've tapped \(number) times")
            }
        }
    }
}
