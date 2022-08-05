//
//  Concentration.swift
//  Concentraton
//
//  Created by 1C on 27/03/2022.
//

import Foundation

struct Concentration {
    
    private (set) var cards = [Card]()
    private (set) var score = 0
    private (set) var cardsAlreadyOpened = Set<Card>()
    private (set) var flipCount = 0
    
    // Computed Value
    private var identifierOnlyOneCardIsFaceUp: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                if newValue == nil {
                    cards[index].isMatched = false
                    cards[index].OpenedOnce = false
                }
            }
        }
    }
        
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index)): index is not in array of cards")
        
        if !cards[index].isMatched {
            
            if let matchIndex = identifierOnlyOneCardIsFaceUp, matchIndex != index {

                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Points.bonusForMatch
                    
                } else {
                    for currentIndex in [index, matchIndex] {
                        if cardsAlreadyOpened.contains(cards[currentIndex]) && cards[currentIndex].OpenedOnce {  //
                            score -= Points.penaltyForDisMatch
                        } else {
                            cardsAlreadyOpened.insert(cards[currentIndex])
                        }
                    }
                    cards[index].OpenedOnce = true
                }
                cards[index].isFaceUp = true
                
            } else {
                identifierOnlyOneCardIsFaceUp = index
                cards[index].OpenedOnce = true
                
            }
            flipCount += 1
        }
        
    }

    init(numberOfCardsPair:Int) {
        
        assert(numberOfCardsPair>0, "Concentration.init(\(numberOfCardsPair)): numberOfCardsPair must be greater then 0")
        
        for _ in 1..<numberOfCardsPair {
            
            let card = Card()
            cards += [card, card]
            
        }
        
        shuffleTheCards()
        score = 0
        flipCount = 0
        cardsAlreadyOpened.removeAll()
        identifierOnlyOneCardIsFaceUp = nil
    }
    
    mutating private func shuffleTheCards() {
      
        cards.shuffle()
        
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

extension Array {
    mutating func shuffle() {
        
        for i in 0..<count - 1 {
            let j = i.arc4random
            swapAt(i, j)
        }
        
    }
}
