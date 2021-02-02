//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Marko Kramar on 13.11.2020..
//

import UserNotifications
import CodeScanner
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    enum SortType {
        case byName, byMostRecent
    }
    
    @State private var sortType: SortType = .byName
    var sortingTitle: String {
        switch sortType {
        case .byName:
            return "Sorted by name"
        case .byMostRecent:
            return "Sorted by most recent"
        }
    }
    
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    @EnvironmentObject var prospects: Prospects
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people.sorted(by: sortType == .byName ? sortedByName : sortedByMostRecent)
        case .contacted:
            return prospects.people.filter { $0.isContacted }.sorted(by: sortType == .byName ? sortedByName : sortedByMostRecent)
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }.sorted(by: sortType == .byName ? sortedByName : sortedByMostRecent)
        }
    }
    
    @State private var isShowingScanner = false
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: filter == .none && prospect.isContacted ? "checkmark.circle" : "")
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {
                self.showingActionSheet = true
            }) {
                Image(systemName: "arrow.up.arrow.down")
                Text("\(sortingTitle)")
            }, trailing: Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Marko Kramar\nmarko.kramar7@gmail.com", completion: handleScan)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Sort contacts"), buttons: [
                    .default(Text("By name")) { self.sortType = .byName },
                    .default(Text("By most recent")) { self.sortType = .byMostRecent },
                    .cancel()
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed")
        }
    }
    
    func sortedByName(p1: Prospect, p2: Prospect) -> Bool {
        p1.name < p2.name
    }
    
    func sortedByMostRecent(p1: Prospect, p2: Prospect) -> Bool {
        p1.dateEntered > p2.dateEntered
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        // can be written this way also: let addRequest: () -> Void = {
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}
