//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Marko Kramar on 30.11.2020..
//

import SwiftUI

struct ContentView_old1: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
            }
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}
