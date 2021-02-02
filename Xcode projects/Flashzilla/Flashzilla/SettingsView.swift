//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 26.11.2020..
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("canHaveTwoAttempts") private var canHaveTwoAttempts = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General settings")) {
                    Toggle("User can attempt two times?", isOn: $canHaveTwoAttempts)
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
