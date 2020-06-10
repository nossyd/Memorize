//
//  MemorayGame.swift
//  Memorize
//
//  Created by Dysson Vielmann on 5/31/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import Foundation

// struct for data
// always ask self: What does this model do?
struct MemoryGame<CardContent> where CardContent: Equatable {
    // private (set) means setting the var is private but reading it is not private
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // get all the cards and see which ones are faceup and see if theres only one
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        // this is how we react when someone sets the value of indexOfTheOneAndOnlyFaceUpCard
        set {
            for index in cards.indices {
                // newValue is special var only appears inside set of computed property
                    cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // LOGIC goes here
    // a way to choose a card; thus mutating func bc changing
    mutating func choose(card: Card) {
        // chosen card
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            // card already faced up
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // changes isMatched to true if cards are same card
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
            // turns our chosen up face up
            self.cards[chosenIndex].isFaceUp = true
            }
            // turns cards faced down except one just chose
            else {
                // chosen card is our index card and thus becomes only card face up
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    
    // create number of pairs of cards
    // empty array of cards
    // for loop to create cards and append to empty array
    // create content for cards
    // init = implicitly changing self
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    //represents a single card
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        // "don't care" type bc can be image, string, int, etc.
        var content: CardContent
        var id: Int
    }
}
