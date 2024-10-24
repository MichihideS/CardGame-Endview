//
//  CardView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-21.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var game: Game
    var card: Card
    
    var body: some View {
        VStack {
            Button(action: {
                game.chooseCard()
            }, label: {
                VStack {
                    Text("\(card.name)")
                    Text("\(card.attack)")
                    Text("\(card.defense)")
                    Text("\(game.checkSpecialAttribute(element: card.special))")
                }
            })

        }
    }
}

#Preview {
    CardView(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "")).environmentObject(Game())
}
