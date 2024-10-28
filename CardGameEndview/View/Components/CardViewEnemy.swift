//
//  CardViewBig.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-27.
//

import SwiftUI

struct CardViewEnemy: View {
    @EnvironmentObject var game: Game
    var card: Card
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("\(card.name)")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Text("ATK: \(card.attack)")
                        Text("DEF: \(card.defense)")
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Text("\(game.checkSpecialAttribute(element: card.special))")
            }
            .foregroundColor(.black)
            .frame(width: 140, height: 200)
            .padding(10)
            .border(Color.black, width: 1)
            .background(Color(card.color))
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
    }
}

#Preview {
    CardViewEnemy(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "", color: Color(.purple))).environmentObject(Game())
}
