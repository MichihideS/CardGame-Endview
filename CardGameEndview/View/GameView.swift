//
//  GameView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct GameView: View {
    @State var text: String = "Test"
    
    @State var counter: Int = 0
    
    @State var playerCards = []
    
    func drawCards() {
        while counter < 3 {
            let randomNumber = Int.random(in: 0...2)
            playerCards.append(CardDeck().deckOfCards[randomNumber])
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
            })
        }
    }
}

#Preview {
    GameView()
}
