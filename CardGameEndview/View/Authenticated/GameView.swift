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
                            game.resetGame()
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
            
                        Text("Enemy Health: \(game.enemyHealth)")
                            .font(.title)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.red.opacity(0.6))
                                    .stroke(.black, lineWidth: 3)
                                    .opacity(0.8)
                            }
                            .frame(width: 300, alignment: .trailing)
                            .padding(.top, 10)
                        
                        Text("Status: \(game.enemyStatus)")
                            .font(.title2).padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(game.enemyStatusColor.opacity(0.6))
                                    .stroke(.black, lineWidth: 1)
                                    .opacity(0.8)
                            }
                            .padding(.bottom, 30)
                            .frame(width: 300, alignment: .trailing)
                        
                        Text("Status: \(game.playerStatus)")
                            .font(.title2)
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(game.playerStatusColor.opacity(0.6))
                                    .stroke(.black, lineWidth: 1)
                                    .opacity(0.8)
                            }
                            .frame(width: 300, alignment: .leading)
                        
                        Text("Player Health: \(game.playerHealth)")
                            .font(.title)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.green.opacity(0.6))
                                    .stroke(.black, lineWidth: 3)
                                    .opacity(0.8)
                            }
                            .frame(width: 300, alignment: .leading)
                            .padding(.bottom, 10)
                        
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
            }
        }
        .overlay {
            if let usedCardEnemy = game.usedCardEnemy {
                CardViewEnemyBig(card: usedCardEnemy)
            }
            
            if let index = game.indexOfCardPressed {
                CardViewBig(card: game.playerCards[index])
            }
            
            if let _ = game.whoWon {
                VStack {
                    MainTextTitle(text: game.whoWonText)
                    
                    ButtonMainMenu(function: {
                        game.resetGame()
                    }, text: "Play Again")
                    
                    NavigationButton(destination: LoggedInView(), text: "Main Menu")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial).ignoresSafeArea()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            startGame = false
            game.resetGame()
        }
    }
}

#Preview {
    GameView().environmentObject(Game())
}
