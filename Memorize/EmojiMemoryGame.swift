//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dysson Vielmann on 5/31/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import Foundation


class EmojiMemoryGame: ObservableObject {
    // type is string bc emojis are strings
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // create function that creates pair of cards of array
    // want private so that others cannot create a memory game
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    // this is the portal this viewmodel provides onto our model thru its cards array
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    // intents have to be non-private
    // ex. choose = draft
    // choose a card
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    // start a new game
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
