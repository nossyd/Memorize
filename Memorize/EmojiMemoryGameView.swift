//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dysson Vielmann on 5/29/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        // Layout for all cards
        // this is how we attach our model to our view via view model
        Grid (viewModel.cards) { card in
            CardView(card: card).onTapGesture {self.viewModel.choose(card: card)}
            .padding(5)
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}


// Struct for cards
struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
    }
    
    // body as func to clean up code
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
        ZStack {
            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise:  true).padding(5).opacity(0.4)
            Text(card.content).font(.system(size: fontSize(for: size)))
        }
        .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
