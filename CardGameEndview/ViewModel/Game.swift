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
    @Published var enemyCardsDefense: [Card] = []
    @Published var enemyHealth = 50
    @Published var playerHealth = 50
    @Published var enemyStatus = "Normal"
    @Published var playerStatus = "Normal"
    @Published var isCardPressed = false
    @Published var indexOfCardPressed: Int? = nil
    @Published var usedCard: Card? = nil
    @Published var enemyDefenseResponse: Int = 0
    
    @Published var isPlayerDamaged = false
    @Published var isEnemyDamaged = false
    
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
    
    func playerTurnCalculations() {
        guard let index = indexOfCardPressed else { return }
        
        usedCard = playerCards[index]
        
        guard let usedCard = usedCard else { return }
        
        checkEnemyDefenseCards()
        
        switch usedCard.special {
        case 1:
            if isEnemyDamaged {
                enemyStatus = "Burned"
            }
        case 2:
            if isEnemyDamaged {
                enemyStatus = "Drowned"
            }
        case 3:
            if isEnemyDamaged {
                enemyStatus = "Death"
            }
        case 4:
            if isEnemyDamaged {
                enemyStatus = "Windy"
            }
        default:
            enemyStatus = enemyStatus
        }
        
        if enemyDefenseResponse < 0 {
            enemyHealth = enemyHealth - (usedCard.attack - enemyDefenseResponse)
        }
        
        playerCards.remove(at: index)
        indexOfCardPressed = nil
        isCardPressed = false
    }
    
    func enemyTurn() -> Int {
        
        return 5
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
    
    // Checks the ID of the card you pressed so you can find the index of where it is at
    func checkIfCardIsPressed(uuid: UUID) {
        let index = playerCards.firstIndex(where: {
            $0.id == uuid
        })
        
        guard let index = index else { return }
        
        indexOfCardPressed = index
        isCardPressed = true
    }
    
    // Resets variables if you cancel the card you pressed
    func cancelBigCard() {
        indexOfCardPressed = nil
        isCardPressed = false
    }
    
    // Checks if the enemy has any defense cards and places them in a new array
    func checkEnemyDefenseCards() {
        for card in enemyCards {
            if card.defense > 0 {
                enemyCardsDefense.append(card)
            }
        }
        
        if enemyCardsDefense.isEmpty {
            return
        } else {
            enemyDefenseTurn()
        }
    }
    
    // Checks which defense card to use if enemy has any and sets a new value to the card and checks if enemy takes damage
    func enemyDefenseTurn() {
        let defense = Int.random(in: 0...enemyCardsDefense.count - 1)
        
        guard let usedCard = usedCard else { return }
        
        let healthDifference = enemyCardsDefense[defense].defense - usedCard.attack
        
        if healthDifference < 0 {
            isEnemyDamaged = true
        }
        
        enemyDefenseResponse = enemyCardsDefense[defense].defense
        
        guard let index = enemyCards.firstIndex(where: {
            $0.id == enemyCardsDefense[defense].id
        }) else { return }
        
        enemyCards.remove(at: index)
    }
}
