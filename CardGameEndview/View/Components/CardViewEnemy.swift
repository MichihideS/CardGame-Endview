//
//  CardView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-29.
//

import SwiftUI

// Basic design for the enemy card deck overview
struct CardViewEnemy: View {
    @EnvironmentObject var game: Game
    var card: Card
    
    var body: some View {
        VStack {
            
        }
        .foregroundColor(.black)
        .frame(width: 100, height: 150)
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 3)
                .opacity(0.8)
        }
        
        .background(Image("game_bg")
            .resizable()
            .clipShape(.rect(cornerRadius: 5))
        )
    }
}

#Preview {
    CardViewEnemy(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "", color: Color(.purple))).environmentObject(Game())
}
