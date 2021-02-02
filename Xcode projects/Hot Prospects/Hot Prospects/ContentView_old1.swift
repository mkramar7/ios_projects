//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Marko Kramar on 05/11/2020.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ContentView_old1: View {
    let user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct ContentView_old1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_old1()
    }
}
