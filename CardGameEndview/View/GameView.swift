//
//  GameView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game
    

    
    var body: some View {
        VStack {
            Button(action: {
                game.drawCards(player: 1)
                game.counter = 0
                game.drawCards(player: 2)
                print(game.playerCards)
            }, label: {
                Text("DRAWTEST")
            }).padding()
            
            Button(action: {
                game.playerCards = []
                game.counter = 0
                print(game.playerCards)
            }, label: {
                Text("Reset")
            })
            
            .padding(.bottom, 50)
            
            HStack {
                ForEach(game.enemyCards) { cards in
                    CardView(card: cards)
                }
            }
            
            Text("Enemy Health: \(game.enemyHealth)").font(.title).padding(.bottom, 30)
            Text("Player Health: \(game.playerHealth)").font(.title).padding(.bottom, 30)
            
            HStack {
                ForEach(game.playerCards) { cards in
                    CardView(card: cards)
                }
            }
            
            Button(action: {
                print("\(game.playerCards[2])")
            }, label: {
                Text("PRINT")
            })
            
            Button(action: {
                
            }, label: {
                Text("Button")
            })
        }
    }
}

#Preview {
    GameView().environmentObject(Game())
}
