//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Marko Kramar on 04/10/2020.
//

import SwiftUI

@main
struct BookWormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
