//
//  EmojiMemoryGame.swift
//  Memorize_assignment2
//
//  Created by Marko Kramar on 29/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

struct Theme {
    var name: String
    var cardSet: [String]
    var numberOfPairsOfCards: Int?
    var color: (red: Double, green: Double, blue: Double)
}

let themes = [
    Theme(name: "Haloween", cardSet: ["👻", "🎃", "🕷"], color: (red: 255, green: 128, blue: 0)),
    Theme(name: "Sports", cardSet: ["🏀", "🏈", "⚾", "🎱", "🎾", "🥊"], numberOfPairsOfCards: 6, color: (red: 0, green: 0, blue: 255)),
    Theme(name: "Animals", cardSet: ["🐼", "🐔", "🦄", "🐷", "🐝"], color: (red: 153, green: 76, blue: 0)),
    Theme(name: "Faces", cardSet: ["😀", "😢", "😉"], color: (red: 255, green: 0, blue: 0)),
    Theme(name: "Technology", cardSet: ["⌚️", "📱", "🖥", "⌨️"], color: (red: 192, green: 192, blue: 192)),
    Theme(name: "Nature", cardSet: ["🏝", "🏞", "🏔", "🏕"], numberOfPairsOfCards: 4, color: (red: 0, green: 255, blue: 0))
]

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let numberOfPairsOfCards = theme.numberOfPairsOfCards ?? Int.random(in: 1...theme.cardSet.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            return theme.cardSet[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var gameStarted: Bool {
        model.gameStarted
    }
    
    static let theme = themes.randomElement()!
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func startGame() {
        objectWillChange.send()
        model.startGame()
    }
}
