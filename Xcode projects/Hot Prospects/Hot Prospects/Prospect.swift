//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Marko Kramar on 09/11/2020.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    var dateEntered = Date()
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
            return
        } catch {
            print("Unable to load data from documents directory.")
            print("Exact error: \(error.localizedDescription)")
        }
        
        self.people = []
    }
    
    private func save() {
        do {
            let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data to documents directory.")
            print("Exact error: \(error.localizedDescription)")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
