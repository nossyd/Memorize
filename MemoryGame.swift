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
        cards.shuffle()
    }
    
    //represents a single card
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            // prop obs that allows us to start/stop bonus time
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        // "don't care" type bc can be image, string, int, etc.
        var content: CardContent
        var id: Int
        
            // MARK: - Bonus Time

        // This could give matching bonus points if user matches card
        // before a certain amount of time passes during which the card is face up


        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit : TimeInterval = 6

        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?

        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0

        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }

        // percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }

        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        // whether we are currently face up, unmatched and have not yet used up bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        // called when the card transitions to face up state
        // first starts tracking time
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        // called when the card goes back face down (or gets matched)
        // ends tracking time
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }

    }
}


