//
//  ContentView.swift
//  Memorize_assignment2
//
//  Created by Marko Kramar on 29/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    let activeTheme = EmojiMemoryGame.theme
    
    var body: some View {
        VStack {
            if viewModel.gameStarted {
                HStack {
                    Text("Active theme: \(activeTheme.name)")
                    Spacer()
                    Text("Score: \(viewModel.score)")
                }
                .padding()
                
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                .padding()
                .foregroundColor(Color.orange)
            } else {
                Button(action: {
                    self.viewModel.startGame()
                }) {
                    Text("New game")
                }
            }
        }
    }
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    let activeThemeColor = EmojiMemoryGame.theme.color
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color(red: activeThemeColor.red, green: activeThemeColor.green, blue: activeThemeColor.blue))
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
