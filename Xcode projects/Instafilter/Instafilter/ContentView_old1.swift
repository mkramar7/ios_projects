//
//  ContentView.swift
//  Instafilter
//
//  Created by Marko Kramar on 14/10/2020.
//

import SwiftUI

struct ContentView_old1: View {
    @State private var blurAmount: CGFloat = 0
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        
        return VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_old1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_old1()
    }
}
