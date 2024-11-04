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
                    withAnimation {
                        game.isShowingBigCard = true
                    }
                }
            }, label: {
                VStack {
                    VStack {
                        Text("\(card.name)")
                            .bold()
                            .padding(1)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.thinMaterial.opacity(0.6))
                                    .opacity(0.8)
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
    CardView(card: Card(name: "Test", attack: 30, defense: 20, cost: 5, special: 3, image: "firey_wave", color: Color(.purple))).environmentObject(Game())
}
