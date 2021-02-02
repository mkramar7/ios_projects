//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Marko Kramar on 08/11/2020.
//

import SwiftUI
import SamplePackage

struct ContentView_old10: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}
