//
//  ContentView.swift
//  DiceChallenge
//
//  Created by Marko Kramar on 07.12.2020..
//

import SwiftUI

struct ContentView: View {
    var dices = Dices()
    
    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Image(systemName: "die.face.3")
                    Text("Roll dice")
                }
            
            DiceRollHistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
        }
        .environmentObject(dices)
    }
}
