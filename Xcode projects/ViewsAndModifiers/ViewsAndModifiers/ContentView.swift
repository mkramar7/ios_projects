//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Marko Kramar on 14/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitleStyle() -> some View {
        self.modifier(ProminentTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        .prominentTitleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
