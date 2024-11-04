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
                    
                    Image("game_bg")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(.rect(cornerRadius: 5))
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .foregroundColor(.black)
                .frame(width: 100, height: 150)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(card.color)
                        .stroke(.black, lineWidth: 3)
                        .opacity(0.8)
                }
                .background(.white)
            })
            
        }
        
    }
}

#Preview {
    CardView(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "", color: Color(.purple))).environmentObject(Game())
}
