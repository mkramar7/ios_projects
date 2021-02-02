//
//  EmojiMemoryGame.swift
//  Memorize_retyped
//
//  Created by Marko Kramar on 14/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

// ViewModel
class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "🧙‍♀️", "🧟‍♀️", "👔", "💰", "💣", "📚", "🔭", "⚔️", "☎️"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { _ in
            // Extra credit - have the emoji on cards be randomly chosen from a larger set of emoji
            let randomlyChosenEmoji = emojis[Int.random(in: 0..<emojis.count)]
            return randomlyChosenEmoji
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // Mark: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
