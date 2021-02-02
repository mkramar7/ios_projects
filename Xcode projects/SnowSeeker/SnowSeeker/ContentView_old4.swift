//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Marko Kramar on 10.12.2020..
//

import SwiftUI

struct ContentView_old4: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}
