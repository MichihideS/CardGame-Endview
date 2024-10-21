//
//  Card.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import Foundation

struct Card: Identifiable {
    var id = UUID()
    var name: String
    var attack: Int
    var defense: Int
    var cost: Int
    var special: Int
    var image: String
}
