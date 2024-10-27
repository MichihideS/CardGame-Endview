//
//  CardDeck.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-20.
//

import Foundation

let BURN = 1
let DROWN = 2
let DEATH = 3
let WIND = 4

struct CardDeck {
    
    let deckOfCards: [Card] = [
        Card(name: "Water Strike", attack: 3, defense: 0, cost: 5, special: DROWN, image: ""),
        Card(name: "Fiery Wave", attack: 5, defense: 0, cost: 3, special: BURN, image: ""),
        Card(name: "Massive Wall", attack: 0, defense: 20, cost: 3, special: 0, image: ""),
        Card(name: "Dark Energy", attack: 3, defense: 0, cost: 4, special: 0, image: ""),
        Card(name: "Big Poke", attack: 8, defense: 0, cost: 5, special: 0, image: ""),
        Card(name: "Small Paper", attack: 0, defense: 3, cost: 2, special: 0, image: ""),
        Card(name: "Pen of Hell", attack: 20, defense: 0, cost: 6, special: 0, image: ""),
        Card(name: "Absorbing Tissue", attack: 0, defense: 2, cost: 1, special: 0, image: ""),
        Card(name: "Dark Mist", attack: 5, defense: 0, cost: 5, special: DEATH, image: ""),
        Card(name: "Dark Assassin", attack: 1, defense: 0, cost: 3, special: DEATH, image: ""),
        Card(name: "Whirlpool", attack: 8, defense: 0, cost: 4, special: DROWN, image: ""),
        Card(name: "Swift Strike", attack: 10, defense: 0, cost: 2, special: WIND, image: "")
            ]
}
