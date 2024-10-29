//
//  CardView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-29.
//

import SwiftUI

struct CardViewEnemy: View {
    @EnvironmentObject var game: Game
    var card: Card
    
    var body: some View {
        VStack {
            
        }
        .foregroundColor(.black)
        .frame(width: 100, height: 150)
        .padding(10)
        .border(Color.black, width: 1)
        
        .background(Image("game_bg")
            .resizable())
    }
}

#Preview {
    CardViewEnemy(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "", color: Color(.purple))).environmentObject(Game())
}
