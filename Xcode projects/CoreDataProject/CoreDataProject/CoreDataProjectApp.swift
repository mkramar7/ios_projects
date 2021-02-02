//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Marko Kramar on 08/10/2020.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
