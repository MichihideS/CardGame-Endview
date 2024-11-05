//
//  CardView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-21.
//

import SwiftUI

// Design for the basic card shown in the hand as a overview.
struct CardView: View {
    @EnvironmentObject var game: Game
    var card: Card
    
    var body: some View {
        VStack {
            // When you press a card the UUID of the card will be saved.
            Button(action: {
                if game.isCardPressed == false {
                    game.checkIfCardIsPressed(uuid: card.id)
                    withAnimation {
                        game.isShowingBigCard = true
                    }
                }
            }, label: {
                VStack {
                    VStack {
                        HStack {
                            Text("\(card.name)")
                                .bold()
                                .padding(1)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.thinMaterial.opacity(0.6))
                                        .opacity(0.8)
                                }
                            
                            Spacer()
                            
                            Text("\(card.cost)")
                                .bold()
                                .padding(1)
                                .foregroundStyle(.blue)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.thinMaterial)
                                        .opacity(0.8)
                                }
                        }
                        
                        HStack {
                            Text("ATK: \(card.attack)")
                                .bold()
                                .font(.system(size: 11))
                                .padding(1)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.thinMaterial.opacity(0.6))
                                        .opacity(0.8)
                                }
                            
                            Spacer()
                            
                            Text("DEF: \(card.defense)")
                                .bold()
                                .font(.system(size: 11))
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
            .disabled(game.isNotAllowedToAct)
        }
    }
}

#Preview {
    CardView(card: Card(name: "Color", attack: 30, defense: 20, cost: 5, special: 3, image: "firey_wave", color: Color(.gray))).environmentObject(Game())
}
