//
//  PlayerData.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import Foundation
import FirebaseFirestore

// Data for the DB, wins and losses is automatically set to 0.
struct PlayerData: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var wins: Int = 0
    var losses: Int = 0
}
