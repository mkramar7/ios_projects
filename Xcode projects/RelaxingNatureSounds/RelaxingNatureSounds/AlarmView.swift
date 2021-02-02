//
//  AlarmView.swift
//  RelaxingNatureSounds
//
//  Created by Marko Kramar on 07/10/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct AlarmView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var secondsUntilStop: Int
    @Binding var countdownStarted: Bool
    
    private let possibleMinutes = [5, 10, 15, 20, 30, 45, 60, 120].map { $0 * 60 }
    
    var body: some View {
        VStack {
            Section {
                Text("Stop playing after")
                    .font(.title)
                Picker(selection: $secondsUntilStop, label: Text("")) {
                    ForEach(possibleMinutes, id: \.self) { minutes in
                        if minutes < 3600 {
                            Text("\(minutes / 60) minutes")
                        } else {
                            Text("\(minutes / 3600) hours")
                        }
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity, maxHeight: 150, alignment: .bottom)
                
            }.padding(0)
            
            Button(action: {
                self.countdownStarted = true
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Start countdown")
                    .font(.title2)
            }
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10.0)
            
            Spacer()
        }.padding(0)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(secondsUntilStop: .constant(5), countdownStarted: .constant(false))
    }
}
