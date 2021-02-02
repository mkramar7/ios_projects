//
//  DicesHistory.swift
//  DiceChallenge
//
//  Created by Marko Kramar on 07.12.2020..
//

import SwiftUI

struct DiceRollHistoryView: View {
    @EnvironmentObject var dices: Dices
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dices.allDices, id: \.self) { dice in
                    HStack {
                        Text("Number of sides: \(dice.sides)")
                            .font(.subheadline)
                        Spacer()
                        Text("Result: \(dice.result)")
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("Rolled dices history")
        }
    }
}
