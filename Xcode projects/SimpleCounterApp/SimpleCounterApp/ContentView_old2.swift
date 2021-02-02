//
//  ContentView.swift
//  SimpleCounterApp
//
//  Created by Marko Kramar on 26.12.2020..
//

import SwiftUI

struct ContentView_old2: View {
    var body: some View {
        print("ContentView")
        return LabelView_old2()
    }
}

struct LabelView_old2: View {
    @State private var counter = 0
    
    var body: some View {
        print("LabelView")
        return VStack {
            Button("Tap me!") { counter += 1 }
            if counter > 0 {
                Text("You've tapped \(counter) times")
            }
        }
    }
}
