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
                
                Image(card.image)
                    .resizable()
                    .frame(width: 180, height: 180)
                    .clipShape(.rect(cornerRadius: 5))
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Text("\(game.checkSpecialAttribute(element: card.special))")
            }
            .foregroundColor(.black)
            .frame(width: 200, height: 300)
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(card.color)
                    .stroke(.black, lineWidth: 3)
                    .opacity(0.8)
            }
            .background(.white)
            
            
            ButtonGame(function: {
                game.checkWhosTurn()
            }, text: "Confirm")
            
            ButtonGame(function: {
                game.cancelBigCard()
            }, text: "Cancel")
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.black.opacity(0.6))
        
    }
}

#Preview {
    CardViewBig(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "", color: Color(.purple))).environmentObject(Game())
}
