//
//  CardViewBig.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-27.
//

import SwiftUI

struct CardViewBig: View {
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
            .frame(width: 200, height: 300)
            .padding(10)
            .border(Color.black, width: 1)
            .background(.blue)
            
            Button(action: {
                game.playerTurnCalculations()
            }, label: {
                Text("Confirm")
                    .frame(width: 120)
                    .font(.title)
                    .bold()
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
                
            })
            
            Button(action: {
                game.cancelBigCard()
            }, label: {
                Text("Cancel")
                    .frame(width: 120)
                    .font(.title)
                    .bold()
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
                
            })
        }
    }
}

#Preview {
    CardViewBig(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "")).environmentObject(Game())
}
