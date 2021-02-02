//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 17.11.2020..
//

import SwiftUI

struct ContentView_old8: View {
    
    var body: some View {
        /*ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped")
                }
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped")
                }
                //.allowsHitTesting(false)
         }
         */
        
        VStack {
            Text("Hello")
            Spacer().frame(height: 300)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped")
        }
    }
}
