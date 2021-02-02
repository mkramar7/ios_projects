//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Marko Kramar on 11.12.2020..
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @ObservedObject var favorites = Favorites()
    @ObservedObject var searchFilter = SearchFilter()
    
    @State private var selectedSortType: SortType = .defaultSort
    @State private var sortActionSheetShown = false
    
    @State private var searchFilterSheetShown = false
    
    var body: some View {
        NavigationView {
            List(getFilteredAndSortedResorts()) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)                            
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading:
                Button(action: {
                    self.sortActionSheetShown = true
                }) {
                    Image(systemName: "arrow.up.arrow.down")
                }, trailing:
                Button(action: {
                    self.searchFilterSheetShown = true
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
            )
            .actionSheet(isPresented: $sortActionSheetShown, content: {
                ActionSheet(title: Text("Sorting"), message: Text("Please select sort type"), buttons: [
                    .default(Text("Default"), action: {
                        self.selectedSortType = .defaultSort
                    }),
                    .default(Text("Alphabetical"), action: {
                        self.selectedSortType = .alphabetical
                    }),
                    .default(Text("By country"), action: {
                        self.selectedSortType = .country
                    })
                ])
            })
            .sheet(isPresented: $searchFilterSheetShown) {
                SearchFilterView()
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .environmentObject(searchFilter)
        // .phoneOnlyStackNavigationView() // -> this is used to force showing only primary NavigationView screen in iPhone 11 (portrait and landscape)
    }
    
    func getSortedResorts() -> [Resort] {
        if selectedSortType == .alphabetical {
            return resorts.sorted(by: { (resort1, resort2) -> Bool in
                resort1.name < resort2.name
            })
        } else if selectedSortType == .country {
            return resorts.sorted(by: { (resort1, resort2) -> Bool in
                resort1.country < resort2.country
            })
        }
        
        return resorts
    }
    
    func getFilteredAndSortedResorts() -> [Resort] {
        var resorts = getSortedResorts()
        
        if let filterCountry = searchFilter.country {
            resorts = resorts.filter({ $0.country.contains(filterCountry) })
        }
        
        if let filterSize = searchFilter.size {
            resorts = resorts.filter({ $0.size == filterSize })
        }
        
        if let filterPrice = searchFilter.price {
            resorts = resorts.filter({ $0.price == filterPrice })
        }
        
        return resorts
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

// Filtering and sorting
enum SortType {
    case defaultSort, alphabetical, country
}
