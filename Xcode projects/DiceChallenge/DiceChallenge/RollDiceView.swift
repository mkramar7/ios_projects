//
//  DiceView.swift
//  DiceChallenge
//
//  Created by Marko Kramar on 07.12.2020..
//

import SwiftUI

struct RollDiceView: View {
    let possibleDiceSides = [4, 6, 8, 10, 12, 20, 100]
    
    @State private var chosenNumberOfSides = 6
    @State private var randomNumber: Int?
    
    @EnvironmentObject var dices: Dices
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack {
            Text("Choose number of sides")
                .padding(.top, 20)
            Picker("Choose dice type", selection: $chosenNumberOfSides) {
                ForEach(possibleDiceSides, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(InlinePickerStyle())
            
            Button("Roll dice") {
                rollDice()
            }
            .font(.headline)
            .padding(.bottom, 20)
            
            if let rnd = randomNumber {
                Text("Dice result: \(rnd)")
            }
        }
    }
    
    func rollDice() {
        feedback.notificationOccurred(.success)
        randomNumber = Int.random(in: 0...chosenNumberOfSides)
        dices.allDices.append(Dice(sides: chosenNumberOfSides, result: randomNumber!))
    }
}
