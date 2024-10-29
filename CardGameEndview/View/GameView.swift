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
                    
                    Text("Enemy Cards: \(game.enemyCards.count)").padding(5).background(.thinMaterial.opacity(0.6))
                    Text("Enemy Health: \(game.enemyHealth)").font(.title).padding(5).background(.thinMaterial.opacity(0.6))
                    Text("Status: \(game.enemyStatus)").font(.title2).padding(5).background(.thinMaterial.opacity(0.6)).padding(.bottom, 30)
                    
                    Text("Status: \(game.playerStatus)").font(.title2).padding(5).background(.thinMaterial.opacity(0.6))
                    Text("Player Health: \(game.playerHealth)").font(.title).padding(5).background(.thinMaterial.opacity(0.6)).padding(.bottom, 30)
                    
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
                    .foregroundColor(.black)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.thinMaterial)
                            .stroke(.black, lineWidth: 2)
                    }
                }
            }.overlay {
                if let usedCardEnemy = game.usedCardEnemy {
                    CardViewEnemy(card: usedCardEnemy)
                }
                
                if let index = game.indexOfCardPressed {
                    CardViewBig(card: game.playerCards[index])
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("game_bg").opacity(0.8))
        .overlay {
            if let _ = game.whoWon {
                VStack {
                    Text(game.whoWonText)
                    
                    Button(action: {
                        game.resetGame()
                    }, label: {
                        Text("Play Again")
                        
                    })
                    .font(.title2)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial).ignoresSafeArea()
            }
        }
    }
}

#Preview {
    GameView().environmentObject(Game())
}
