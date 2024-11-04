//
//  CardDeck.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-20.
//

import Foundation
import SwiftUI

let BURN = 1
let DROWN = 2
let DEATH = 3
let WIND = 4
let BLIND = 5

struct CardDeck {
    let deckOfCards: [Card] = [
        Card(name: "Water Strike", attack: 3, defense: 0, cost: 5, special: DROWN, image: "water_strike", color: Color(.blue)),
        Card(name: "Water Strike", attack: 3, defense: 0, cost: 5, special: DROWN, image: "water_strike", color: Color(.blue)),
        Card(name: "Water Strike", attack: 3, defense: 0, cost: 5, special: DROWN, image: "water_strike", color: Color(.blue)),
        Card(name: "Fiery Wave", attack: 5, defense: 0, cost: 3, special: BURN, image: "fiery_wave", color: Color(.red)),
        Card(name: "Fiery Wave", attack: 5, defense: 0, cost: 3, special: BURN, image: "fiery_wave", color: Color(.red)),
        Card(name: "Fiery Wave", attack: 5, defense: 0, cost: 3, special: BURN, image: "fiery_wave", color: Color(.red)),
        Card(name: "Massive Wall", attack: 0, defense: 20, cost: 3, special: 0, image: "massive_wall", color: Color(.gray)),
        Card(name: "Massive Wall", attack: 0, defense: 20, cost: 3, special: 0, image: "massive_wall", color: Color(.gray)),
        Card(name: "Massive Wall", attack: 0, defense: 20, cost: 3, special: 0, image: "massive_wall", color: Color(.gray)),
        Card(name: "Dark Energy", attack: 3, defense: 0, cost: 4, special: 0, image: "dark_energy", color: Color(.gray)),
        Card(name: "Dark Energy", attack: 3, defense: 0, cost: 4, special: 0, image: "dark_energy", color: Color(.gray)),
        Card(name: "Dark Energy", attack: 3, defense: 0, cost: 4, special: 0, image: "dark_energy", color: Color(.gray)),
        Card(name: "Big Poke", attack: 8, defense: 0, cost: 5, special: 0, image: "big_poke", color: Color(.gray)),
        Card(name: "Big Poke", attack: 8, defense: 0, cost: 5, special: 0, image: "big_poke", color: Color(.gray)),
        Card(name: "Big Poke", attack: 8, defense: 0, cost: 5, special: 0, image: "big_poke", color: Color(.gray)),
        Card(name: "Small Paper", attack: 0, defense: 3, cost: 2, special: 0, image: "small_paper", color: Color(.gray)),
        Card(name: "Small Paper", attack: 0, defense: 3, cost: 2, special: 0, image: "small_paper", color: Color(.gray)),
        Card(name: "Small Paper", attack: 0, defense: 3, cost: 2, special: 0, image: "small_paper", color: Color(.gray)),
        Card(name: "Pen of Hell", attack: 20, defense: 0, cost: 6, special: 0, image: "pen_of_hell", color: Color(.gray)),
        Card(name: "Pen of Hell", attack: 20, defense: 0, cost: 6, special: 0, image: "pen_of_hell", color: Color(.gray)),
        Card(name: "Pen of Hell", attack: 20, defense: 0, cost: 6, special: 0, image: "pen_of_hell", color: Color(.gray)),
        Card(name: "Absorbing Tissue", attack: 0, defense: 2, cost: 1, special: 0, image: "absorbing_tissue", color: Color(.gray)),
        Card(name: "Absorbing Tissue", attack: 0, defense: 2, cost: 1, special: 0, image: "absorbing_tissue", color: Color(.gray)),
        Card(name: "Absorbing Tissue", attack: 0, defense: 2, cost: 1, special: 0, image: "absorbing_tissue", color: Color(.gray)),
        Card(name: "Dark Mist", attack: 5, defense: 0, cost: 5, special: DEATH, image: "dark_mist", color: Color(.purple)),
        Card(name: "Dark Mist", attack: 5, defense: 0, cost: 5, special: DEATH, image: "dark_mist", color: Color(.purple)),
        Card(name: "Dark Mist", attack: 5, defense: 0, cost: 5, special: DEATH, image: "dark_mist", color: Color(.purple)),
        Card(name: "Dark Assassin", attack: 1, defense: 0, cost: 3, special: DEATH, image: "dark_assassin", color: Color(.purple)),
        Card(name: "Dark Assassin", attack: 1, defense: 0, cost: 3, special: DEATH, image: "dark_assassin", color: Color(.purple)),
        Card(name: "Dark Assassin", attack: 1, defense: 0, cost: 3, special: DEATH, image: "dark_assassin", color: Color(.purple)),
        Card(name: "Whirlpool", attack: 8, defense: 0, cost: 4, special: DROWN, image: "whirlpool", color: Color(.blue)),
        Card(name: "Whirlpool", attack: 8, defense: 0, cost: 4, special: DROWN, image: "whirlpool", color: Color(.blue)),
        Card(name: "Whirlpool", attack: 8, defense: 0, cost: 4, special: DROWN, image: "whirlpool", color: Color(.blue)),
        Card(name: "Sword of Light", attack: 5, defense: 0, cost: 5, special: BLIND, image: "sword_of_light", color: Color(.orange)),
        Card(name: "Sword of Light", attack: 5, defense: 0, cost: 5, special: BLIND, image: "sword_of_light", color: Color(.orange)),
        Card(name: "Sword of Light", attack: 5, defense: 0, cost: 5, special: BLIND, image: "sword_of_light", color: Color(.orange)),
        Card(name: "Phoenix", attack: 8, defense: 0, cost: 6, special: BLIND, image: "swift_strike", color: Color(.orange)),
        Card(name: "Phoenix", attack: 8, defense: 0, cost: 6, special: BLIND, image: "swift_strike", color: Color(.orange)),
        Card(name: "Phoenix", attack: 8, defense: 0, cost: 6, special: BLIND, image: "swift_strike", color: Color(.orange))
    ]
}
