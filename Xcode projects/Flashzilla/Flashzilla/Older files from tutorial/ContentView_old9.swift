//
//  ContentViwe.swift
//  Flashzilla
//
//  Created by Marko Kramar on 18.11.2020..
//

import SwiftUI

struct ContentView_old9: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello Wold")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
}
