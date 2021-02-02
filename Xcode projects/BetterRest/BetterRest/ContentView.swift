//
//  ContentView.swift
//  BetterRest
//
//  Created by Marko Kramar on 17/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var idealBedtime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        let prediction = try! model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
        
        let sleepTime = wakeUp - prediction.actualSleep
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter.string(from: sleepTime)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount, specifier: "%g") hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .accessibility(value: Text("\(sleepAmount, specifier: "%g") hours of sleep"))
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    /*Stepper(value: $coffeeAmount, in: 1...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }*/
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) {
                            Text("\($0) cup" + ($0 == 1 ? "" : "s"))
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    
                }
                
                Section {
                    Text("Calculated bedtime: \(idealBedtime)")
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
