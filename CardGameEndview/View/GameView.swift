//
//  GameView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct GameView: View {
    var cardDeck = CardDeck()
    
    @State var text: String = "Test"
    
    @State var counter: Int = 0
    
    @State var playerCards: [Card] = []
    
    func drawCards() {
        while counter < 6 {
            let randomNumber = Int.random(in: 0...11)
            playerCards.append(cardDeck.deckOfCards[randomNumber])
            counter += 1
        }
    }
    
    var body: some View {
        VStack {
            Text("\(text)")
            
            Button(action: {
                drawCards()
                print(playerCards)
            }, label: {
                Text("DRAWTEST")
            }).padding()
            
            Button(action: {
                playerCards = []
                counter = 0
                print(playerCards)
            }, label: {
                Text("Reset")
            })
            
            HStack {
                ForEach(playerCards) { cards in
                    CardView(card: cards)
                }
            }
        }
    }
}

#Preview {
    GameView()
}
