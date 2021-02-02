//
//  ContentView.swift
//  BullsEye
//
//  Created by Marko Kramar on 01/03/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Put the bulls eye as ckose as you can to:")
                Text("\(self.target)")
            }
            
            Spacer()
            
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer()
            
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit Me")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there"),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                "You scored \(pointsForCurrentRound()) points this round."),
                             dismissButton: .default(Text("Awesome")))
            }
        
            Spacer()
            
            HStack {
                Button(action: {
                    
                }) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("999999")
                Spacer()
                Text("Round")
                Text("999")
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Info")
                }
            }.padding(.bottom, 20)
        }
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        100 - abs(target - sliderValueRounded())
    }
}
 	
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
