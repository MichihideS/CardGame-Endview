//
//  RandomizerCardDeck.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-20.
//

import Foundation

class RandomizerCardDeck {
    var counter: Int = 0
   
    var playerCards: Array? = []
    
    func drawCards() -> Array<Any> {
        while counter < 3 {
            let randomNumber = Int.random(in: 1...3)
            playerCards?.append(CardDeck().deckOfCards[randomNumber])
        }
        
        return playerCards!
    }
}
