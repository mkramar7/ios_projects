//
//  SandwichStore.swift
//  Sandwiches
//
//  Created by Marko Kramar on 27.12.2020..
//

import Foundation

class SandwichStore: ObservableObject {
    @Published var sandwiches: [Sandwich]
    
    init(sandwiches: [Sandwich] = []) {
        self.sandwiches = sandwiches
    }
}

let testStore = SandwichStore(sandwiches: testData)
