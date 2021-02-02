//
//  ContentView.swift
//  HabitTracker
//
//  Created by Marko Kramar on 21/09/2020.
//

import SwiftUI

struct Activity: Codable, Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var timesCompleted = 0
}

class Activities: ObservableObject {
    @Published var items: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "habits")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct AddNewActivityView: View {
    @State private var title = ""
    @State private var description = ""
    
    @ObservedObject var activities: Activities
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarItems(trailing: Button("Save") {
                let activity = Activity(title: self.title, description: self.description)
                self.activities.items.append(activity)
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle("Add new habit")
        }
    }
}

struct DetailActivityView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var timesCompleted = 0
    
    @ObservedObject var activities: Activities
    @State var activityId: UUID
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            Button("Times completed: \(timesCompleted)") {
                self.timesCompleted += 1
            }
        }
        .navigationBarItems(trailing: Button("Save") {
            let itemIndex = self.activities.items.firstIndex(where: { $0.id == self.activityId })!
            activities.items[itemIndex].title = self.title
            activities.items[itemIndex].description = self.description
            activities.items[itemIndex].timesCompleted = self.timesCompleted
            self.presentationMode.wrappedValue.dismiss()
        })
        .navigationBarTitle("Edit habit \(self.title)")
        .onAppear {
            let activity = self.activities.items.filter { $0.id == self.activityId }.first!
            self.title = activity.title
            self.description = activity.description
            self.timesCompleted = activity.timesCompleted
        }
    }
}

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var activityDetailsVisible = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink(destination: DetailActivityView(activities: activities, activityId: activity.id)) {
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.headline)
                            Text(activity.description)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.activityDetailsVisible = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .navigationBarTitle(Text("Habit Tracker"))
        }.sheet(isPresented: $activityDetailsVisible) {
            AddNewActivityView(activities: self.activities)
        }
    }
    
    func removeItems(at offset: IndexSet) {
        activities.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
