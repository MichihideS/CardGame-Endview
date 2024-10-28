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
        ZStack {
            VStack {
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
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(game.enemyCards) { cards in
                                CardView(card: cards)
                            }
                        }
                    }
                    
                    Text("Enemy Cards: \(game.enemyCards.count)")
                    Text("Enemy Health: \(game.enemyHealth)").font(.title)
                    Text("Status: \(game.enemyStatus)").font(.title2).padding(.bottom, 30)
                    
                    Text("Statis: \(game.playerStatus)").font(.title2)
                    Text("Player Health: \(game.playerHealth)").font(.title).padding(.bottom, 30)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(game.playerCards) { cards in
                                CardView(card: cards)
                                
                            }
                        }
                    }
                }
            }.overlay {
                if let index = game.indexOfCardPressed {
                    CardViewBig(card: game.playerCards[index])
                }
                
                if let usedCardEnemy = game.usedCardEnemy {
                    CardViewEnemy(card: usedCardEnemy)
                }
            }
        }
    }
}

#Preview {
    GameView().environmentObject(Game())
}
