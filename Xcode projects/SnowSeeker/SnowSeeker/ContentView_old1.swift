//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Marko Kramar on 10.12.2020..
//

import SwiftUI

struct ContentView_old1: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello World")
            }
            .navigationBarTitle("Primary")
            
            Text("Secondary")
        }
    }
}
