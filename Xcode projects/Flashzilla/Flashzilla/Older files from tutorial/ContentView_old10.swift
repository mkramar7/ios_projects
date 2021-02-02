//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marko Kramar on 18.11.2020..
//

import SwiftUI

struct ContentView_old10: View {
    
    var body: some View {
        Text("Hwllo World")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                print("Moved back to the foreground")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                print("User has taken screenshot")
            }
    }
}
