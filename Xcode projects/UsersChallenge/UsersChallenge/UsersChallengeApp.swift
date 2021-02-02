//
//  UsersChallengeApp.swift
//  UsersChallenge
//
//  Created by Marko Kramar on 12/10/2020.
//

import SwiftUI

@main
struct UsersChallengeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
