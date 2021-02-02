//
//  MemoryGame.swift
//  Memorize
//
//  Created by Marko Kramar on 12/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        // If selected card is not faced up and it's not already matched
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            // If there is already one card faced up (getter for "indexOfTheOneAndOnly..." will find this)
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                // Check if selected card content is equal to content of one card that is already up
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                self.cards[chosenIndex].isFaceUp = true
            } else {
                // If there is no cards already faced up, setter for "indexOfTheOneAndOnly..." will make that card face up
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
