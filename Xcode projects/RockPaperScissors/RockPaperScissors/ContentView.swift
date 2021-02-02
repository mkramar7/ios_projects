//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Marko Kramar on 16/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct BigButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.title)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            .padding(5)
    }
}

extension View {
    func biggerButton() -> some View {
        self.modifier(BigButtonModifier())
    }
}

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    
    @State private var appCurrentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var roundInfoPresented = false
    @State private var questionNumber = 1
    @State private var playerScore = 0 {
        didSet {
            self.playerWonLastRound = playerScore > oldValue
        }
    }
    
    @State private var playerWonLastRound = false
    
    var body: some View {
        VStack {
            Text("Player's score: \(playerScore)")
            Text("App's move: \(possibleMoves[appCurrentChoice])")
            Text("Player should \(shouldWin ? "win!" : "lose!")")
            VStack {
                Text("Your choice:").padding()
                ForEach(possibleMoves, id: \.self) { move in
                    Button(move) {
                        self.handlePlayerChoosing(move)
                    }
                    .biggerButton()
                }
            }
            Spacer()
        }.alert(isPresented: $roundInfoPresented) {
            Alert(title: Text("Round \(questionNumber) result"), message: Text(playerWonLastRound ? "You won! Congratulations" : "Unfortunately, you lost this round."), dismissButton: .default(Text("OK")) {
                    self.questionNumber += 1
                    self.appCurrentChoice = Int.random(in: 0..<3)
                    self.shouldWin = Bool.random()
                })
        }
    }
    
    func handlePlayerChoosing(_ playerMove: String) {
        let computerMove = possibleMoves[appCurrentChoice]
        if computerMove == playerMove {
            print("Draw! Please make another choice!")
            return
        }
        
        if shouldWin {
            switch computerMove {
            case "Rock":
                playerScore = playerMove == "Paper" ? playerScore + 1 : playerScore - 1
            case "Paper":
                playerScore = playerMove == "Scissors" ? playerScore + 1 : playerScore - 1
            case "Scissors":
                playerScore = playerMove == "Rock" ? playerScore + 1 : playerScore - 1
            default:
                break
            }
        } else {
            switch computerMove {
            case "Rock":
                playerScore = playerMove == "Paper" ? playerScore - 1 : playerScore + 1
            case "Paper":
                playerScore = playerMove == "Scissors" ? playerScore - 1 : playerScore + 1
            case "Scissors":
                playerScore = playerMove == "Rock" ? playerScore - 1 : playerScore + 1
            default:
                break
            }
        }
        
        
        if self.questionNumber <= 10 {
            roundInfoPresented = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
