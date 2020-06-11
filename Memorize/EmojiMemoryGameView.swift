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
        VStack {
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration : 0.75)){ self.viewModel.choose(card: card)}
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            .font(.largeTitle)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: {Text("New Game")})
        }
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
    
    // how to animate pies and sync with model bonusTimeRemaining
    @State private var animatedBonusRemaining: Double = 0
    private func startAnimationBonusTime () {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // body as func to clean up code
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
        ZStack {
            Group {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise:  true)
                        .onAppear {
                            self.startAnimationBonusTime()
                    }
                }
                else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise:  true)
                }
            }.padding(5).opacity(0.4).transition(.scale)
            Text(card.content).font(.system(size: fontSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
        }
        .cardify(isFaceUp: card.isFaceUp)
        .transition(AnyTransition.scale)
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
