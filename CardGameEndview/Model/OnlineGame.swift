//
//  OnlineGame.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-31.
//

import Foundation
import FirebaseFirestore

/*
 * Ny collection game som ska innehålla spelet och varje runda med hjälp av en array där varje objekt i arrayen representerar
 * en "runda" så att spelarna vet vad som händer.
 * Listener som lyssnar på så att 2 spelar connectar
 */

struct OnlineGame: Codable, Identifiable  {
    @DocumentID var id: String?
    var playerOne: String
    var playerTwo: String
    // var attackCard: Card
    // var defenseCard: Card
    var whosTurn: Int
    var whoWon: Int
    
}
