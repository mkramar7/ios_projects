//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Marko Kramar on 02.12.2020..
//

import SwiftUI

struct ContentView_old5: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello World")
                    .frame(width: geo.size.width * 0.9, height: 40)
            }
            .background(Color.green)
            
            Text("More text")
                .background(Color.blue)
        }
    }
}
