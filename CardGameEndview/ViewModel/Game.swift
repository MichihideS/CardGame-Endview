//
//  Game.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-20.
//

import Foundation

class Game: ObservableObject {
    var db = DbConnection()
    var cardDeck = CardDeck()
    
    @Published var text: String = "Test"
    @Published var counter: Int = 0
    
    @Published var playerCards: [Card] = []
    @Published var enemyCards: [Card] = []
    @Published var enemyCardsDefense: [Card] = []
    @Published var enemyCardsAttack: [Card] = []
    
    @Published var enemyHealth = 50
    @Published var playerHealth = 50
    @Published var enemyStatus = "Normal"
    @Published var playerStatus = "Normal"
    @Published var isCardPressed = false
    @Published var whosTurn = 1
    @Published var whoWon: Int? = nil
    @Published var whoWonText = ""
    @Published var indexOfCardPressed: Int? = nil
    
    @Published var usedCard: Card? = nil
    @Published var enemyDefenseResponse: Int = 0
    @Published var usedCardEnemy: Card? = nil
    
    let BURN = "Burned"
    let DROWN = "Drowned"
    let DEATH = "Death"
    let WIND = "Windy"
    let NORMAL = "Normal"
    
    // Randomizes which card are drawn by both the player and enemy when you start the game
    func drawCardsStart() {
        while counter < 6 {
            var randomNumber = Int.random(in: 0...11)
            playerCards.append(cardDeck.deckOfCards[randomNumber])
            
            randomNumber = Int.random(in: 0...11)
            enemyCards.append(cardDeck.deckOfCards[randomNumber])
            counter += 1
        }
    }
    
    // Checks whos turn it is so you know if you gonna attack or defend
    func checkWhosTurn() {
        if whosTurn == 2 {
            playerDefenseTurnCalculations()
        } else {
            playerTurnCalculations()
        }
    }
    
    func playerTurnCalculations() {
        guard let index = indexOfCardPressed else { return }
        
        usedCard = playerCards[index]
        
        guard let usedCard = usedCard else { return }
        
        if usedCard.attack > 0 {
            checkEnemyDefenseCards()
            
            let playerAttack = checkForStatusDrown(attack: usedCard.attack)
            
            if (playerAttack - enemyDefenseResponse) > 0  {
                let enemyDefense = checkForStatusWind(defense: enemyDefenseResponse)
                
                enemyHealth = enemyHealth - (playerAttack - enemyDefense)
                
                if usedCard.special > 0 {
                    checkSpecialAttackHit(special: usedCard.special)
                }
            }
            
            playerCards.remove(at: index)
            indexOfCardPressed = nil
            isCardPressed = false
            enemyTurn()
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
    
    // When player attacks and lands a hit with a special modifier it will set the status of the player accordingly
    func checkSpecialAttackHit(special: Int) {
        switch special {
        case 1:
            if whosTurn == 1 {
                enemyStatus = BURN
            } else {
                playerStatus = BURN
            }
        case 2:
            if whosTurn == 1 {
                enemyStatus = DROWN
            } else {
                playerStatus = DROWN
            }
        case 3:
            if whosTurn == 1 {
                enemyStatus = DEATH
            } else {
                playerStatus = DEATH
            }
        case 4:
            if whosTurn == 1 {
                enemyStatus = WIND
            } else {
                playerStatus = WIND
            }
        default:
            return
        }
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
            enemyDefenseResponse = 0
        } else {
            enemyDefenseTurn()
        }
    }
    
    // Checks which defense card to use if enemy has any and sets a new value to the card and checks if enemy takes damage
    func enemyDefenseTurn() {
        let defense = Int.random(in: 0...enemyCardsDefense.count - 1)
    
        enemyDefenseResponse = enemyCardsDefense[defense].defense
        
        guard let index = enemyCards.firstIndex(where: {
            $0.id == enemyCardsDefense[defense].id
        }) else { return }
        
        enemyCards.remove(at: index)
    }
    
    // Puts all the attack cards in a new array and randoms a card which is used for attack and deleted in the
    // original array after
    func enemyTurn() {
        checkWinner()
        whosTurn = 2
        checkForStatusBurned()
        checkForStatusDeath()
        startTurn()
        
        var attack: Int = 0
        
        for card in enemyCards {
            if card.attack > 0 {
                enemyCardsAttack.append(card)
            }
        }
        
        if enemyCardsAttack.isEmpty {
            startTurn()
            resetVariables()
        } else {
            attack = Int.random(in: 0...enemyCardsAttack.count - 1)
            
            usedCardEnemy = enemyCardsAttack[attack]
            
            guard let index = enemyCards.firstIndex(where: {
                $0.id == enemyCardsAttack[attack].id
            }) else { return }
            
            enemyCards.remove(at: index)
        }
    }
    
    // Checks if enemy attack is bigger then player defense and if it is reduces the health accordinly
    func playerDefenseTurnCalculations() {
        guard let index = indexOfCardPressed else { return }
        
        usedCard = playerCards[index]
        
        guard let usedCard = usedCard else { return }
        guard let usedCardEnemy = usedCardEnemy else { return }
        
        if usedCard.defense > 0 {
            let enemyAttack = checkForStatusDrown(attack: usedCardEnemy.attack)
            
            if (enemyAttack - usedCard.defense) > 0  {
                let playerDefense = checkForStatusWind(defense: usedCard.defense)
                
                playerHealth = playerHealth - (enemyAttack - playerDefense)
                
                if usedCardEnemy.special > 0 {
                    checkSpecialAttackHit(special: usedCardEnemy.special)
                }
            }
            
            playerCards.remove(at: index)
            indexOfCardPressed = nil
            isCardPressed = false
            resetVariables()
            checkWinner()
        }
    }
    
    func playerDefenseTurnCalculationsNoCard() {
        guard let usedCardEnemy = usedCardEnemy else { return }
        
        let enemyAttack = checkForStatusDrown(attack: usedCardEnemy.attack)
        
        playerHealth = playerHealth - enemyAttack
        
        if usedCardEnemy.special > 0 {
            checkSpecialAttackHit(special: usedCardEnemy.special)
        }
        
        resetVariables()
        checkWinner()
    }
    
    // Resets variables so the turns can repeat until someone reaches a winning condition
    func resetVariables() {
        usedCardEnemy = nil
        usedCard = nil
        enemyCardsDefense = []
        enemyCardsAttack = []
        whosTurn = 1
        enemyDefenseResponse = 0
        checkForStatusBurned()
        checkForStatusDeath()
        startTurn()
    }
    
    // Resets the whole game and srarts it up again
    func resetGame() {
        counter = 0
        playerCards = []
        enemyCards = []
        enemyHealth = 50
        playerHealth = 50
        enemyStatus = NORMAL
        playerStatus = NORMAL
        isCardPressed = false
        whoWon = nil
        whoWonText = ""
        indexOfCardPressed = nil
        resetVariables()
        drawCardsStart()
    }
    
    // Ends the turn and starts a new function depending on where you are in the game
    func endTurn() {
        let randomNumber = Int.random(in: 0...11)
        playerCards.append(cardDeck.deckOfCards[randomNumber])
        
        if whosTurn == 1 {
            enemyTurn()
        } else {
            playerDefenseTurnCalculationsNoCard()
        }
    }
    
    
    // Adds a new card at the start of every players turn
    func startTurn() {
        let randomNumber = Int.random(in: 0...11)
        
        if whosTurn == 1 {
            playerCards.append(cardDeck.deckOfCards[randomNumber])
        } else {
            enemyCards.append(cardDeck.deckOfCards[randomNumber])
        }
    }
    
    // Checks if anyone has reached the winning condition and ends the game if someone has
    func checkWinner() {
        if enemyHealth <= 0 {
            db.plusOne()
            whoWon = 1
            whoWonText = "You Won!"
        } else if playerHealth <= 0{
            db.minusOne()
            whoWon = 2
            whoWonText = "You Lose!"
        }
    }
    
    // Checks if player has the status burned at the start of their turn and if they have reduces health by 5
    func checkForStatusBurned() {
        if whosTurn == 2 && enemyStatus == BURN {
            enemyHealth = enemyHealth - 5
            checkWinner()
        }
        
        if whosTurn == 1 && playerStatus == BURN {
            playerHealth = playerHealth - 5
            checkWinner()
        }
    }
    
    // Check if player has the status death at the start of their turn and if they do they automatically lose
    func checkForStatusDeath() {
        if whosTurn == 2 && enemyStatus == DEATH {
            enemyHealth = 0
            checkWinner()
        }
        
        if whosTurn == 1 && playerStatus == DEATH {
            playerHealth = 0
            checkWinner()
        }
    }
    
    // Check if player has the status windy when they block an attack and if they do the defense value will be halved
    func checkForStatusWind(defense: Int) -> Int {
        var defenseModified = 0
        if whosTurn == 1 && enemyStatus == WIND {
            if defense > 0 {
                defenseModified = defense / 2
            }
        } else if whosTurn == 1 {
            defenseModified = defense
        }
        
        if whosTurn == 2 && playerStatus == WIND {
            if defense > 0 {
                defenseModified = defense / 2
            }
        } else if whosTurn == 2 {
            defenseModified = defense
        }
    
        return defenseModified
    }
    
    // Check if player has the status drown when they attack and if they do the attack value will be halved
    func checkForStatusDrown(attack: Int) -> Int {
        var attackModified = 0
        
        if whosTurn == 2 && enemyStatus == DROWN {
            if attack > 0 {
                attackModified = attack / 2
            }
        } else if whosTurn == 2 {
            attackModified = attack
        }
        
        if whosTurn == 1 && playerStatus == DROWN {
            if attack > 0 {
                attackModified = attack / 2
            }
        } else if whosTurn == 1 {
            attackModified = attack
        }
        
        return attackModified
    }
    
    // Checks the win percentage of the player
    func winRatio(wins: Int, losses: Int) -> Int {
        let winsDouble = Double(wins)
        let totalGamesDouble = Double(wins + losses)
        
        var ratio = winsDouble / totalGamesDouble * 100
        
        if totalGamesDouble == 0 {
            ratio = 0
        }
        
        let rounded = ceil(ratio)
        return Int(rounded)
    }
}

