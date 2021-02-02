//
//  ContentView.swift
//  WeSplit
//
//  Created by Marko Kramar on 05/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    // @State private var numberOfPeople = 0
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // let peopleCount = Double(numberOfPeople + 2)
        guard let peopleCount = Double(numberOfPeople) else {
            return 0
        }
        
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100  * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var originalAmount: Double {
        Double(checkAmount) ?? 0
    }
    
    var totalTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        return originalAmount / 100  * tipSelection
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    /*Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }*/
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount details")) {
                    Text("Original amount: $\(self.originalAmount, specifier: "%.2f")")
                    Text("Total tip: $\(self.totalTip, specifier: "%.2f")")
                    Text("Total amount: $\((self.originalAmount + self.totalTip), specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .black)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
