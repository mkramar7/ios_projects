//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Marko Kramar on 05/11/2020.
//

import SwiftUI

struct ContentView_old5: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}
