//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 17.11.2020..
//

import SwiftUI

struct ContentView_old1: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                print("In progress: \(inProgress)!")
            }) {
                print("Long pressed!")
            }
    }
}

struct ContentView_old1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_old1()
    }
}
