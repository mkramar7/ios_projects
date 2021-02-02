//
//  MemoryGame.swift
//  Memorize_assignment2
//
//  Created by Marko Kramar on 29/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var score: Int = 0
    var gameStarted: Bool = false
    var alreadySeenIndexes = [Int]()
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Matched
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    // If chosen card is already seen, decrease points by 1; otherwise, add it to already seen indexes array
                    if alreadySeenIndexes.contains(chosenIndex) {
                        score -= 1
                    } else {
                        alreadySeenIndexes.append(chosenIndex)
                    }
                }
                
                self.cards[chosenIndex].isFaceUp = true
            } else {
                alreadySeenIndexes.append(chosenIndex)
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func increaseScore() {
        score += 1
    }
    
    mutating func startGame() {
        gameStarted = true
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2+1, content: content))
            cards.shuffle()
        }
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
}
