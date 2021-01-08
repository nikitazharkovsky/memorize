//
//  MemoryGame.swift
//  Memorize
//
//  Created by Svetlana Bolotova on 08.10.2020.
//  Copyright © 2020 Svetlana Bolotova. All rights reserved.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable {
    private(set) var cards : Array<Card>
    var theme: Theme
    var score = 0
    var cardsInPair = 2
    
    private var indexOfTheOneAndOnlyFaceUpCard: Array<Int> {
        get { cards.indices.filter { cards[$0].isFaceUp } }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {

            let faceUpCards = indexOfTheOneAndOnlyFaceUpCard
            
            if faceUpCards.count == 0
                || faceUpCards.count == cardsInPair {
                for index in cards.indices {
                    cards[index].isFaceUp = index == chosenIndex
                }
            } else {
                if faceUpCards.count == cardsInPair - 1 {
                    let matches = faceUpCards.filter {cards[chosenIndex].content == cards[$0].content}
                    if matches.count == faceUpCards.count {
                            cards[chosenIndex].isMatched = true
                            score += cardsInPair
                            if cards[chosenIndex].bonusTimeRemaining > 0 {
                                score += 1
                            }
                            for matchIndex in matches {
                                cards[matchIndex].isMatched = true
                                if cards[matchIndex].bonusTimeRemaining > 0 {
                                    score += 1
                                }
                            }
                    } else {
                        for i in [chosenIndex] + faceUpCards {
                            if cards[i].alreadySeen {
                                score -= 1
                                if cards[chosenIndex].bonusTimeRemaining == 0 {
                                    score -= 1
                                }
                            }
                            else {
                                cards[i].alreadySeen = true
                            }
                        }
                    }
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init (numberOfPairsOfCard: Int, cardsInPair: Int, theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCard {
            let content = cardContentFactory(pairIndex)
            for cardIndex in 0..<cardsInPair {
                cards.append(Card(content: content, id: pairIndex * cardsInPair + cardIndex))
            }
        }
        cards.shuffle()
        self.cardsInPair = cardsInPair
        self.theme = theme
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
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
        
        var alreadySeen : Bool = false
        
        var content: CardContent
        var id: Int
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUptime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - pastFaceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUptime
            lastFaceUpDate = nil
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
    }
}
