//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Marko Kramar on 08/10/2020.
//

import SwiftUI
import CoreData

struct ContentView_old1: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.onAppear {
            self.moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    }
}

struct ContentView_old1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_old1().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
