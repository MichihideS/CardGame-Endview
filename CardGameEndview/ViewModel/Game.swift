//
//  Game.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-20.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    var db = DbConnection()
    var cardDeck = CardDeck()
    
    @Published var isComputer: Bool = false
    
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
    @Published var enemyStatusColor = Color(.white)
    @Published var playerStatusColor = Color(.white)
    
    @Published var isCardPressed = false
    @Published var whosTurn = 1
    @Published var whosTurnText: String? = nil
    @Published var whoWon: Int? = nil
    @Published var whoWonText = ""
    @Published var indexOfCardPressed: Int? = nil
    
    @Published var usedCard: Card? = nil
    @Published var enemyDefenseResponse: Int = 0
    @Published var usedCardEnemy: Card? = nil
    @Published var usedCardEnemyDefense: Card? = nil
    
    @Published var isShowingBigCard: Bool = false
    @Published var isShowingBigCardEnemyDefense: Bool = false
    @Published var isShowingBigCardEnemyAttack: Bool = false
    @Published var isShowingWhosTurn: Bool = false
    @Published var isNotAllowedToAct = false
    
    let BURN = "Burned"
    let DROWN = "Drowned"
    let DEATH = "Death"
    let WIND = "Windy"
    let NORMAL = "Normal"
    let BLIND = "Blinded"
    
    // Randomizes which card are drawn by both the player and enemy when you start the game.
    func drawCardsStart() {
        var playerCounter = 0
        var enemyCounter = 0
        
        while playerCounter < 6 {
            let randomNumber = Int.random(in: 0...cardDeck.deckOfCards.count - 1)
            var isDupe = false
            
            if playerCards.isEmpty {
                playerCards.append(cardDeck.deckOfCards[randomNumber])
                playerCounter += 1
            } else {
                for card in playerCards {
                    if card.id == cardDeck.deckOfCards[randomNumber].id {
                        print("Found Dupe!")
                        isDupe = true
                        break
                    }
                }
                
                if !isDupe {
                    playerCards.append(cardDeck.deckOfCards[randomNumber])
                    playerCounter += 1
                }
            }
        }
        
        while enemyCounter < 6 {
            let randomNumber = Int.random(in: 0...cardDeck.deckOfCards.count - 1)
            var isDupe = false
            
            if enemyCards.isEmpty {
                enemyCards.append(cardDeck.deckOfCards[randomNumber])
                enemyCounter += 1
            } else {
                for card in enemyCards {
                    if card.id == cardDeck.deckOfCards[randomNumber].id {
                     print("Found Dupe!")
                        isDupe = true
                        break
                    }
                }
                
                if !isDupe {
                    enemyCards.append(cardDeck.deckOfCards[randomNumber])
                    enemyCounter += 1
                }
            }
        }
    }
    
    // Checks whos turn it is so you the program knows if you are attacking or defending.
    func checkWhosTurn() {
        if whosTurn == 2 {
            playerDefenseTurnCalculations()
        } else {
            playerTurnCalculations()
        }
    }
    
    func checkWhosTurnText() {
        if whosTurn == 1 {
            whosTurnText = "Your Turn"
            withAnimation {
                isShowingWhosTurn = true
            }
        } else {
            whosTurnText = "Enemy Turn"
            withAnimation {
                isShowingWhosTurn = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.whosTurnText = nil
            self.isShowingWhosTurn = false
        }
    }
    
    func playerTurnCalculations() {
        var playerAttack = 0
        
        guard let index = indexOfCardPressed else { return }
        
        usedCard = playerCards[index]
        
        guard let usedCard = usedCard else { return }
        
        if usedCard.attack > 0 {
            isNotAllowedToAct = true
            isShowingBigCard = false
            checkEnemyDefenseCards()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                if self.playerStatus == self.DROWN {
                    playerAttack = self.checkForStatusDrown(attack: usedCard.attack)
                } else if self.playerStatus == self.BLIND {
                    playerAttack = self.checkForStatusBlind(attack: usedCard.attack)
                } else {
                    playerAttack = usedCard.attack
                }
                
                if (playerAttack - self.enemyDefenseResponse) > 0  {
                    let enemyDefense = self.checkForStatusWind(defense: self.enemyDefenseResponse)
                    
                    self.enemyHealth = self.enemyHealth - (playerAttack - enemyDefense)
                    
                    if usedCard.special > 0 {
                        self.checkSpecialAttackHit(special: usedCard.special)
                    }
                }
                
                self.usedCardEnemyDefense = nil
                self.playerCards.remove(at: index)
                self.indexOfCardPressed = nil
                self.isCardPressed = false
                self.enemyTurn()
            }
        }
    }
    
    // Checks if the card has a special attribute and returns a string depending on what special it has.
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
    
    // When a player attacks and lands a hit with a special modifier it will set the status of the player accordingly.
    func checkSpecialAttackHit(special: Int) {
        switch special {
        case 1:
            if whosTurn == 1 {
                enemyStatus = BURN
                enemyStatusColor = Color(.red)
            } else {
                playerStatus = BURN
                playerStatusColor = Color(.red)
            }
        case 2:
            if whosTurn == 1 {
                enemyStatus = DROWN
                enemyStatusColor = Color(.blue)
            } else {
                playerStatus = DROWN
                playerStatusColor = Color(.blue)
            }
        case 3:
            if whosTurn == 1 {
                enemyStatus = DEATH
                enemyStatusColor = Color(.purple)
            } else {
                playerStatus = DEATH
                playerStatusColor = Color(.purple)
            }
        case 4:
            if whosTurn == 1 {
                enemyStatus = WIND
                enemyStatusColor = Color(.green)
            } else {
                playerStatus = WIND
                playerStatusColor = Color(.green)
            }
        case 5:
            if whosTurn == 1 {
                enemyStatus = BLIND
                enemyStatusColor = Color(.orange)
            } else {
                playerStatus = BLIND
                playerStatusColor = Color(.orange)
            }
        default:
            break
        }
    }
    
    // Checks the ID of the card you pressed so you can find the index of where the card is.
    func checkIfCardIsPressed(uuid: UUID) {
        let index = playerCards.firstIndex(where: {
            $0.id == uuid
        })
        
        guard let index = index else { return }
        
        indexOfCardPressed = index
        isCardPressed = true
    }
    
    // Resets the index and press card variables if you cancel the card you pressed.
    func cancelBigCard() {
        indexOfCardPressed = nil
        isCardPressed = false
    }
    
    /*
     * Checks if the enemy has any defense cards and places them in a new array and
     * if the array is empty enemy defense is set to 0.
     */
    func checkEnemyDefenseCards() {
        for card in enemyCards {
            if card.defense > 0 {
                enemyCardsDefense.append(card)
            }
        }
        
        if enemyCardsDefense.isEmpty {
            enemyDefenseResponse = 0
            drawOneCard(whoDraws: 2)
        } else {
            enemyDefenseTurn()
        }
    }
    
    /*
     * Checks which defense card to use if enemy has any in the array and sets a new
     * value to the card and, the defense card is randomized based on the new array created.
     */
    func enemyDefenseTurn() {
        let defense = Int.random(in: 0...enemyCardsDefense.count - 1)
    
        enemyDefenseResponse = enemyCardsDefense[defense].defense
        
        guard let index = enemyCards.firstIndex(where: {
            $0.id == enemyCardsDefense[defense].id
        }) else { return }
        
        usedCardEnemyDefense = enemyCardsDefense[defense]
        
        withAnimation {
            isShowingBigCardEnemyDefense = true
        }
            
        enemyCards.remove(at: index)
        
    }
    
    // Puts all the attack cards in a new array and randoms a card which is used for attack and deleted in the
    // original array after
    func enemyTurn() {
        checkWinner()
        whosTurn = 2
        checkWhosTurnText()
        checkForStatusBurned()
        checkForStatusDeath()
        drawOneCard(whoDraws: 2)
        
        var attack: Int = 0
        
        for card in enemyCards {
            if card.attack > 0 {
                enemyCardsAttack.append(card)
            }
        }
        
        if enemyCardsAttack.isEmpty {
            drawOneCard(whoDraws: 2)
            resetVariables()
        } else {
            attack = Int.random(in: 0...enemyCardsAttack.count - 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.usedCardEnemy = self.enemyCardsAttack[attack]
                
                withAnimation {
                    self.isShowingBigCardEnemyAttack = true
                }
                
                guard let index = self.enemyCards.firstIndex(where: {
                    $0.id == self.enemyCardsAttack[attack].id
                }) else { return }
                
                self.enemyCards.remove(at: index)
                self.isNotAllowedToAct = false
            }
        }
    }
    
    // Checks if enemy attack is bigger then player defense and if it is reduces the health accordinly
    func playerDefenseTurnCalculations() {
        guard let index = indexOfCardPressed else { return }
        
        usedCard = playerCards[index]
        
        guard let usedCard = usedCard else { return }
        guard let usedCardEnemy = usedCardEnemy else { return }
        
        if usedCard.defense > 0 {
            isNotAllowedToAct = true
            
            var enemyAttack = 0
            
            if enemyStatus == DROWN {
                enemyAttack = checkForStatusDrown(attack: usedCardEnemy.attack)
            } else if enemyStatus == BLIND {
                enemyAttack = checkForStatusBlind(attack: usedCardEnemy.attack)
            } else {
                enemyAttack = usedCardEnemy.attack
            }
            
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
        checkWhosTurnText()
        enemyDefenseResponse = 0
        checkForStatusBurned()
        checkForStatusDeath()
        isShowingBigCardEnemyDefense = false
        isShowingBigCardEnemyAttack = false
        isNotAllowedToAct = false
    }
    
    // Resets the whole game and starts it up again
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
        enemyStatusColor = Color(.white)
        playerStatusColor = Color(.white)
        resetVariables()
        drawCardsStart()
    }
    
    // Ends the turn and starts a new function depending on where you are in the game
    func endTurn() {
        drawOneCard(whoDraws: 1)
        
        if whosTurn == 1 {
            enemyTurn()
        } else {
            playerDefenseTurnCalculationsNoCard()
        }
    }
    
    func endTurnText() -> String {
        var text = ""
        
        if whosTurn == 1 {
            text = "End Turn"
        } else {
            text = "Don't Defend"
        }
        
        return text
    }
    
    
    // Adds a new card at the start of every players turn
    func startTurn() {
        if whosTurn == 1 {
            drawOneCard(whoDraws: 1)
        } else {
            drawOneCard(whoDraws: 2)
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
    
    
    // Check if player has the status drown when they attack and if they do the attack value will be halved.
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
    
    // Check if player has the status blinded when they attack and if they do they have a 50% chance to miss.
    func checkForStatusBlind(attack: Int) -> Int {
        var attackModified = 0
        let randomNumber = Int.random(in: 1...2)
        
        if whosTurn == 2 && enemyStatus == BLIND {
            if attack > 0 && randomNumber == 1 {
                attackModified = 0
            }
        } else if whosTurn == 2 {
            attackModified = attack
        }
        
        if whosTurn == 1 && playerStatus == BLIND {
            if attack > 0 && randomNumber == 1 {
                attackModified = 0
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
    
    func winRatioColor(wins: Int, Losses: Int) -> Color {
        let colorNumber = winRatio(wins: wins, losses: Losses)
        var color = Color(.white)
        
        if colorNumber > 90 {
            color = Color(.green)
        }
        
        if colorNumber > 70 && colorNumber <= 90  {
            color = Color(.blue)
        }
        
        if colorNumber > 50 && colorNumber <= 70 {
            color = Color(.yellow)
        }
        
        if colorNumber > 30 && colorNumber <= 50 {
            color = Color(.orange)
        }
        
        if colorNumber <= 30 {
            color = Color(.red)
        }
        
        return color
    }
    
    // Draw one card for End turn or start turn (CAN BE OPTIMIZED)
    func drawOneCard(whoDraws: Int) {
        if whoDraws == 1 {
            var playerCounter = 0
            
            while playerCounter < 1 {
                let randomNumber = Int.random(in: 0...cardDeck.deckOfCards.count - 1)
                var isDupe = false
                
                if playerCards.isEmpty {
                    playerCards.append(cardDeck.deckOfCards[randomNumber])
                    playerCounter += 1
                } else {
                    for card in playerCards {
                        if card.id == cardDeck.deckOfCards[randomNumber].id {
                            print("Found Dupe!")
                            isDupe = true
                            break
                        }
                    }
                    
                    if !isDupe {
                        playerCards.append(cardDeck.deckOfCards[randomNumber])
                        playerCounter += 1
                    }
                }
            }
        }
        
        if whoDraws == 2 {
            var enemyCounter = 0
            
            while enemyCounter < 1 {
                let randomNumber = Int.random(in: 0...cardDeck.deckOfCards.count - 1)
                var isDupe = false
                
                if enemyCards.isEmpty {
                    enemyCards.append(cardDeck.deckOfCards[randomNumber])
                    enemyCounter += 1
                } else {
                    for card in enemyCards {
                        if card.id == cardDeck.deckOfCards[randomNumber].id {
                            print("Found Dupe!")
                            isDupe = true
                            break
                        }
                    }
                    
                    if !isDupe {
                        enemyCards.append(cardDeck.deckOfCards[randomNumber])
                        enemyCounter += 1
                    }
                }
            }
        }
    }
}

