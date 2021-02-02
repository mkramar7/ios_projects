//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Marko Kramar on 02.12.2020..
//

import SwiftUI

struct ContentView_old4: View {
    var body: some View {
        GeometryReader { geo in
            Text("Hello World")
                .frame(width: geo.size.width * 0.9)
                .background(Color.red)
        }
    }
}
