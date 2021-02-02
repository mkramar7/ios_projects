//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 17.11.2020..
//

import SwiftUI

struct ContentView_old6: View {
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                simpleSuccess()
            }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
