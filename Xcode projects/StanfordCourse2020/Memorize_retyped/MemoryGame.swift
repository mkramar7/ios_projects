//
//  MemoryGame.swift
//  Memorize_retyped
//
//  Created by Marko Kramar on 14/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

// Model
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            // Content is created
            let content = cardContentFactory(pairIndex)
            
            // Create two identical cards and give them a slightly different ID
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2+1))
        }
        
        // Shuffle the cards, so they don't show in predictable order
        cards.shuffle()
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
