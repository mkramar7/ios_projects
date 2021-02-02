//
//  ContentView.swift
//  SimpleCounterApp
//
//  Created by Marko Kramar on 25.12.2020..
//

import SwiftUI

struct ContentView_old1: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Button(action: { counter += 1 }) {
                Text("Tap me")
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(5)
            }
            
            if counter > 0 {
                Text("You've tapped \(counter) times!")
            } else {
                Text("You've not yet tapped")
            }
        }
        .frame(width: 200, height: 200)
        .border(Color.black)
        .debug()
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
