//
//  ContentView.swift
//  UnitsConverter
//
//  Created by Marko Kramar on 10/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedSourceUnit = "meters"
    @State var selectedDestinationUnit = "meters"
    @State var lengthInput = ""
    
    let lengthUnits: Dictionary<String, UnitLength> = ["meters": .meters, "kilometers": .kilometers, "feets": .feet, "yards": .yards, "miles": .miles]
    var convertedValue: Double {
        guard let value = Double(lengthInput) else {
            return 0
        }
        
        let sourceLength = Measurement(value: value, unit: lengthUnits[selectedSourceUnit]!)
        let destinationLength = sourceLength.converted(to: lengthUnits[selectedDestinationUnit]!)
        
        return destinationLength.value
    }
    
    var body: some View {
        NavigationView {
            Form {
               self.section(named: "Source unit", forUnit: $selectedSourceUnit)
               self.section(named: "Destination unit", forUnit: $selectedDestinationUnit)
               
               Section {
                   TextField("Enter length", text: $lengthInput).keyboardType(.decimalPad)
               }
               
               Section {
                   Text("Converted value: \(convertedValue, specifier: "%.2f")")
               }
           }
            .navigationBarTitle("Unit conversion")
        }
    }
    
    func section(named: String, forUnit selectedUnitStateVar: Binding<String>) -> some View {
        Section(header: Text(named)) {
            Picker("", selection: selectedUnitStateVar) {
                ForEach(Array(self.lengthUnits.keys), id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
