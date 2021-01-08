//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Svetlana Bolotova on 09.10.2020.
//  Copyright © 2020 Svetlana Bolotova. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    public var cardsInPair = CardsInPair
    private static var CardsInPair = 2
    
    private static func createMemoryGame(theme: Theme? = nil) -> MemoryGame<String>
    {
        var gameTheme = theme ?? themes.randomElement()
        gameTheme?.emojiList.shuffle()
        
        let numerOfPairsOfCard = Int.random(in: 2..<6)
        let emojis = gameTheme?.emojiList[0..<numerOfPairsOfCard]
        
        return MemoryGame<String>(numberOfPairsOfCard: emojis!.count, cardsInPair: CardsInPair, theme: gameTheme!) {pairIndex in return emojis![pairIndex]}
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var cardsInModel: Int {
        return cardsInPair
    }
    
    var themeName: String {
        return model.theme.name
    }
    
    var backgroundColor: Color {
        return model.theme.backgroundColor
    }
        
    var cardColor: Color {
        return model.theme.cardColor
    }
    
    var timerColor: Color {
        return model.theme.timerColor
    }
    
    // MARK: - Intent(s)
    func choose (card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame () {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func changeMode () {
        if cardsInPair == 2 {
            EmojiMemoryGame.CardsInPair = 3
            cardsInPair = 3
        } else {
            EmojiMemoryGame.CardsInPair = 2
            cardsInPair = 2
        }
        model = EmojiMemoryGame.createMemoryGame(theme: model.theme)
    }
    
    func shuffle () {
        model.shuffle()
    }
}
