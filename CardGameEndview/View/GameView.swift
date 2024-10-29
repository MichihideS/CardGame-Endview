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
                        game.drawCardsStart()
                        print(game.playerCards)
                    }, label: {
                        Text("DRAWTEST")
                    }).padding()
                    
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
                    
                    Button(action: {
                        game.endTurn()
                    }, label: {
                        Text("End Turn")
                    })
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
                    
                }
            }.overlay {
                if let usedCardEnemy = game.usedCardEnemy {
                    CardViewEnemy(card: usedCardEnemy)
                }
                
                if let index = game.indexOfCardPressed {
                    CardViewBig(card: game.playerCards[index])
                }
                
                VStack {
                    if let _ = game.whoWon {
                        Button(action: {
                            game.resetGame()
                        }, label: {
                            Text("Play Again?")
                                
                        })
                        .font(.title2)
                        .padding()
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(.buttonBorder)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        .background(Color.black.ignoresSafeArea())
                        .edgesIgnoringSafeArea(.all)
                    }
                }
            }
        }
    }
}

#Preview {
    GameView().environmentObject(Game())
}
