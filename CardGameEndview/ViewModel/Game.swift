//
//  Game.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-20.
//

import Foundation

class Game: ObservableObject {
    var cardDeck = CardDeck()
    
    @Published var text: String = "Test"
    @Published var counter: Int = 0
    @Published var playerCards: [Card] = []
    @Published var enemyCards: [Card] = []
    @Published var enemyHealth = 50
    @Published var playerHealth = 50
    
    func drawCards(player: Int) {
        while counter < 6 {
            let randomNumber = Int.random(in: 0...11)
            
            if player == 1 {
                playerCards.append(cardDeck.deckOfCards[randomNumber])
                counter += 1
   
            } else {
                enemyCards.append(cardDeck.deckOfCards[randomNumber])
                counter += 1
                
            }
        }
    }
    
    func chooseCard() {
        enemyHealth = enemyHealth - playerCards[2].attack
    }
    
    func checkSpecialAttribute(element: Int) -> String {
        var specialText = ""
        
        switch element {
        case 1:
            specialText = "Using this card will inflict burn on your foe"
        case 2:
            specialText = "Attack will inflict drowning effect on your foe"
        case 3:
            specialText = "Unless blocked this card will inflict instant death on foe"
        case 4:
            specialText = "Speed is important"
        default:
            return specialText
        }
        
        return specialText
    }
}
