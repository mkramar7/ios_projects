//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Marko Kramar on 10.12.2020..
//

import SwiftUI

struct ContentView_old2: View {
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}
