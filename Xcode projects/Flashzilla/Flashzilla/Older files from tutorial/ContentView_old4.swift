//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 17.11.2020..
//

import SwiftUI

struct ContentView_old4: View {
    
    var body: some View {
        VStack {
            Text("Hello World")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        /*.onTapGesture {
            print("VStack tapped")
        }*/
        //.highPriorityGesture(
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
    }
}
