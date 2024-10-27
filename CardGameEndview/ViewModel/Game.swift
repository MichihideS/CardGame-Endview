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
    @Published var enemyStatus = "Normal"
    @Published var playerStatus = "Normal"
    
    var isDamaged: Bool = false
    
    // Randomizes which card are drawn by both the player and enemy when you start the game
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
    
    //
    func chooseCard(uuid: UUID) {
        let usedCard = cardDeck.deckOfCards.first(where: {
            $0.id == uuid
        })
        
        guard let usedCard = usedCard else { return }
        
        switch usedCard.special {
        case 1: 
            isDamaged = checkDamageTaken(usedCard: usedCard)
            if isDamaged {
                enemyStatus = "Burned"
            }
        case 2:
            isDamaged = checkDamageTaken(usedCard: usedCard)
            if isDamaged {
                enemyStatus = "Drowned"
            }
        case 3:
            isDamaged = checkDamageTaken(usedCard: usedCard)
            if isDamaged {
                enemyStatus = "Death"
            }
        case 4:
            isDamaged = checkDamageTaken(usedCard: usedCard)
            if isDamaged {
                enemyStatus = "Windy"
            }
        default:
            isDamaged = checkDamageTaken(usedCard: usedCard)
            if isDamaged {
                
            }
        }
    }
    
    func enemyTurn() -> Int {
        
        return 5
    }
    
    func checkDamageTaken(usedCard: Card) -> Bool {
        let damageTaken = usedCard.attack
        if damageTaken > 0 {
            return true
        } else {
            return false
        }
    }
    
    // Checks if the card has a special attribute and returns a string depending on what special it has
    func checkSpecialAttribute(element: Int) -> String {
        var specialText = ""
        
        switch element {
        case 1:
            specialText = "Inflicts Burn Effect"
        case 2:
            specialText = "Inflicts Drowning Effect"
        case 3:
            specialText = "Not blocking results in death"
        case 4:
            specialText = "Speed is important"
        default:
            return specialText
        }
        
        return specialText
    }
}
