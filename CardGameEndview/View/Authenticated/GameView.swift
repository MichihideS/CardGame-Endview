//
//  GameView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game
    @State private var startGame: Bool = false
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                if !startGame {
                    VStack {
                        ButtonMainMenu(function: {
                            // TODO
                        }, text: "Play Online")
                        ButtonMainMenu(function: {
                            game.drawCardsStart()
                            startGame = true
                        }, text: "Vs Computer")
                    }
                }
                if startGame {
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(game.enemyCards) { cards in
                                    CardViewEnemy(card: cards)
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
                    }
                    
                    ButtonGame(function: {
                        game.endTurn()
                    }, text: "End Turn")
                    .disabled(game.isCardPressed)
                }
            }.overlay {
                if let usedCardEnemy = game.usedCardEnemy {
                    CardViewEnemyBig(card: usedCardEnemy)
                }
                
                if let index = game.indexOfCardPressed {
                    CardViewBig(card: game.playerCards[index])
                }
            }
        }
        .overlay {
            if let _ = game.whoWon {
                VStack {
                    MainTextTitle(text: game.whoWonText)
                    
                    ButtonMainMenu(function: {
                        game.resetGame()
                    }, text: "Play Again")
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial).ignoresSafeArea(.all)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GameView().environmentObject(Game())
}
