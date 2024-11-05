//
//  GameView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game
    @EnvironmentObject var db: DbConnection
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
            
                        HStack {
                            Text("Mana: \(game.enemyMana)")
                                .font(.title)
                                .padding(5)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.blue.opacity(0.6))
                                        .stroke(.black, lineWidth: 1)
                                        .opacity(0.8)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                            
                            VStack {
                                Text("Health: \(game.enemyHealth)")
                                    .font(.title)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(.red.opacity(0.6))
                                            .stroke(.black, lineWidth: 3)
                                            .opacity(0.8)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                Text("Status: \(game.enemyStatus)")
                                    .font(.title2)
                                    .padding(5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(game.enemyStatusColor.opacity(0.6))
                                            .stroke(.black, lineWidth: 1)
                                            .opacity(0.8)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.trailing, 20)
                        }
                        .padding(.bottom, 10)
                        
                        HStack {
                            VStack {
                                Text("Status: \(game.playerStatus)")
                                    .font(.title2)
                                    .padding(5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(game.playerStatusColor.opacity(0.6))
                                            .stroke(.black, lineWidth: 1)
                                            .opacity(0.8)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Health: \(game.playerHealth)")
                                    .font(.title)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(.green.opacity(0.6))
                                            .stroke(.black, lineWidth: 3)
                                            .opacity(0.8)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 20)
                            
                            Text("Mana: \(game.playerMana)")
                                .font(.title)
                                .padding(5)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.blue.opacity(0.6))
                                        .stroke(.black, lineWidth: 1)
                                        .opacity(0.8)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 20)
                        }
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
                    }, text: game.endTurnText())
                    .disabled(game.isCardPressed)
                    .disabled(game.isNotAllowedToAct)
                }
            }
        }
        .overlay {
            if let usedCardEnemy = game.usedCardEnemy {
                if game.isShowingBigCardEnemyAttack {
                    CardViewEnemyBig(card: usedCardEnemy)
                }
            
            }
            
            if let usedCardEnemyDefense = game.usedCardEnemyDefense {
                if game.isShowingBigCardEnemyDefense {
                    CardViewEnemyBig(card: usedCardEnemyDefense)
                }
            }
            
            if let index = game.indexOfCardPressed {
                if game.isShowingBigCard {
                    CardViewBig(card: game.playerCards[index])
                }
            }
            
            if let whosTurnText = game.whosTurnText {
                if game.isShowingWhosTurn {
                    GameTextTitle(text: whosTurnText)
                }
            }
            
            if let _ = game.whoWon {
                VStack {
                    MainTextTitle(text: game.whoWonText)
                    
                    ButtonMainMenu(function: {
                        game.resetGame()
                    }, text: "Play Again")
                    
                    ButtonMainMenu(function: {
                        startGame = false
                        game.resetGame()
                        db.signOut()
                    }, text: "Main Menu")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial).ignoresSafeArea()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            startGame = false
        }
    }
}

#Preview {
    GameView().environmentObject(Game())
}
