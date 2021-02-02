//
//  ContentView.swift
//  UsersChallenge
//
//  Created by Marko Kramar on 12/10/2020.
//

import SwiftUI

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

class Users: ObservableObject {
    @Published var userList = [User]()
    
    init() {
        let usersUrl = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: usersUrl) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print("Data retrieved: \(String(data: data, encoding: .utf8)!)")
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let decodedData = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.userList = decodedData
                }
            } catch {
                print("Error while decoding data: \(error)")
            }
            
        }.resume()
        
    }
}

struct SimpleDetailFormRow: View {
    var detailLabel: String
    var detailValue: String
    
    var body: some View {
        HStack {
            Text("\(detailLabel):")
                .foregroundColor(Color.gray)
            Text(detailValue)
        }
    }
}

struct DetailView: View {
    var user: CD_User
    var allUsers: FetchedResults<CD_User>
    
    var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        return formatter
    }
    
    var body: some View {
        Form {
            Section(header: Text("Personal details")) {
                SimpleDetailFormRow(detailLabel: "Name", detailValue: user.name!)
                SimpleDetailFormRow(detailLabel: "Email", detailValue: user.email!)
                SimpleDetailFormRow(detailLabel: "Age", detailValue: "\(user.age)")
                SimpleDetailFormRow(detailLabel: "Date of registration", detailValue: shortDateFormatter.string(from: user.reigstered!))
                SimpleDetailFormRow(detailLabel: "Address", detailValue: "\(user.address!)")
                SimpleDetailFormRow(detailLabel: "Company", detailValue: "\(user.company!)")
            }
            
            Section(header: Text("Friends")) {
                List(user.friendsArray) { friend in
                    NavigationLink(destination: DetailView(user: self.findUser(with: friend.id!), allUsers: allUsers)) {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.title)
                            Text(friend.name!)
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("User details"), displayMode: .inline)
    }
    
    func findUser(with id: UUID) -> CD_User {
        self.allUsers.first { $0.id == id }!
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CD_User.entity(), sortDescriptors: [], predicate: nil) var users: FetchedResults<CD_User>
    
    @State private var reachability: Reachability!
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: DetailView(user: user, allUsers: users)) {
                    HStack {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text("\(user.name!), \(user.age)")
                                Text(user.email!)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        
                        Spacer()
                        Image(systemName: "circle.fill")
                            .foregroundColor(user.isActive ? Color.green : Color.red)
                    }
                }
            }
            .navigationBarTitle(Text("Users and friends"))
            .alert(isPresented: $showingConfirmation) {
                Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }.onAppear {
            self.fetchData()
        }
    }
    
    func fetchData() {
        try? self.reachability = Reachability()
        if (reachability.connection == .unavailable) {
            self.confirmationTitle = "Error - no internet"
            self.confirmationMessage = "Unfortunately, a working Internet connection is needed to fetch new data. Only locally stored data will be shown. Please try again later."
            self.showingConfirmation = true
            return
        }
        
        let usersUrl = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: usersUrl) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print("Data retrieved: \(String(data: data, encoding: .utf8)!)")
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let usersList = try decoder.decode([User].self, from: data)
                
                usersList.forEach { user in
                    let cdUser = CD_User(context: moc)
                    cdUser.about = user.about
                    cdUser.address = user.address
                    cdUser.age = Int16(user.age)
                    cdUser.company = user.company
                    cdUser.email = user.email
                    cdUser.id = user.id
                    cdUser.isActive = user.isActive
                    cdUser.reigstered = user.registered
                    cdUser.name = user.name
                    
                    user.friends.forEach { friend in
                        let cdFriend = CD_Friend(context: moc)
                        cdFriend.name = friend.name
                        cdFriend.id = friend.id
                        cdUser.addToFriends(cdFriend)
                    }
                }
                
                if self.moc.hasChanges {
                    try self.moc.save()
                }
            } catch {
                print("Error while decoding data: \(error)")
            }
            
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
