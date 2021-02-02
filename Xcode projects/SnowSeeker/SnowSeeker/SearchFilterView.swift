//
//  SearchFilterView.swift
//  SnowSeeker
//
//  Created by Marko Kramar on 23.12.2020..
//

import SwiftUI

struct SearchFilterView: View {
    @EnvironmentObject var searchFilter: SearchFilter
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedCountry = ""
    @State private var selectedSize = "All"
    @State private var selectedPrice = "All"
    
    let sizes = ["All", "Small", "Average", "Large"]
    let prices = ["All", "$", "$$", "$$$"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Country", text: $selectedCountry)
                    
                    Picker("Size", selection: $selectedSize) {
                        ForEach(sizes, id: \.self) { size in
                            Text(size)
                        }
                    }
                    
                    Picker("Price", selection: $selectedPrice) {
                        ForEach(prices, id: \.self) { price in
                            Text(price)
                        }
                    }
                }
                Spacer()
                Button("Apply filter") {
                    searchFilter.country = selectedCountry.isEmpty ? nil : selectedCountry
                    searchFilter.size = selectedSize != "All" ? sizes.lastIndex(of: selectedSize) : nil
                    searchFilter.price = selectedPrice != "All" ? prices.lastIndex(of: selectedPrice) : nil
                    
                    print("Search filter values: { country: '\(searchFilter.country)', size: '\(searchFilter.size)', price: '\(searchFilter.price)' }")
                    searchFilter.objectWillChange.send()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .onAppear {
                if let filterCountry = searchFilter.country {
                    selectedCountry = filterCountry
                }
                
                if let filterSize = searchFilter.size {
                    selectedSize = sizes[filterSize]
                }
                
                if let filterPrice = searchFilter.price {
                    selectedPrice = prices[filterPrice]
                }
            }
            .navigationBarTitle(Text("Filtering"))
        }
    }
}
