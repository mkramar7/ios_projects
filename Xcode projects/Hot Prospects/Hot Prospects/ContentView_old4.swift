//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Marko Kramar on 05/11/2020.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView_old4: View {
    @ObservedObject var updater = DelayedUpdater()
    
    var  body: some View {
        Text("Value is: \(updater.value)")
    }
}
