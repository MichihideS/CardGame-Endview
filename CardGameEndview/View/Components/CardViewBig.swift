//
//  CardViewBig.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-27.
//

import SwiftUI

// Design of the card when you press a small card to see more info.
struct CardViewBig: View {
    @EnvironmentObject var game: Game
    var card: Card
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("\(card.name)")
                            .font(.title2)
                            .bold()
                            .padding(1)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.thinMaterial.opacity(0.6))
                                    .opacity(0.8)
                            }
                        
                        Spacer()
                        
                        Text("\(card.cost)")
                            .font(.title2)
                            .bold()
                            .padding(1)
                            .foregroundStyle(.blue)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.thinMaterial)
                                    .opacity(0.8)
                            }
                    }
                    .padding(.top, 5)
                    
                    HStack {
                        Text("ATK: \(card.attack)")
                            .bold()
                            .font(.system(size: 18))
                            .padding(1)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.thinMaterial.opacity(0.6))
                                    .opacity(0.8)
                            }
                        
                        Spacer()
                        
                        Text("DEF: \(card.defense)")
                            .bold()
                            .font(.system(size: 18))
                            .padding(1)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.thinMaterial.opacity(0.6))
                                    .opacity(0.8)
                            }
                    }
                    .padding(.bottom, 5)
                }
                
                Image(card.image)
                    .resizable()
                    .frame(width: 180, height: 180)
                    .clipShape(.rect(cornerRadius: 5))
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Text("\(game.checkSpecialAttribute(element: card.special))")
                    .padding(.bottom, 5)
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
                game.isShowingBigCard = false
            }, text: "Cancel")
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.black.opacity(0.6))
    }
}

#Preview {
    CardViewBig(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "fiery_wave", color: Color(.purple))).environmentObject(Game())
}
