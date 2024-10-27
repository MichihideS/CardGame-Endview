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
                if game.isCardPressed == false {
                    game.checkIfCardIsPressed(uuid: card.id)
                }
            }, label: {
                VStack {
                    VStack {
                        Text("\(card.name)")
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
                .frame(width: 100, height: 150)
                .padding(10)
                .border(Color.black, width: 1)
            })
            
        }
        
    }
}

#Preview {
    CardView(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "")).environmentObject(Game())
}
