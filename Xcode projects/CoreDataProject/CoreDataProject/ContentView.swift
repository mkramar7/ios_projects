//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Marko Kramar on 09/10/2020.
//

import SwiftUI

enum PredicateType: String {
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case contains = "CONTAINS"
}

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> {
        fetchRequest.wrappedValue
    }
    
    init(filter: String, sortDescriptors: [NSSortDescriptor], predicateType: PredicateType) {
        self.fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "lastName \(predicateType.rawValue) %@", filter))
    }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(filter: lastNameFilter, sortDescriptors: [NSSortDescriptor(key: "firstName", ascending: true)], predicateType: .beginsWith)
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
