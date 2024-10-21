//
//  CardView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-21.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                VStack {
                    Text("\(card.name)")
                    Text("\(card.attack)")
                    Text("\(card.defense)")
                    Text("\(card.special)")
                }
            })

        }
    }
}

#Preview {
    CardView(card: Card(name: "TestAttack", attack: 20, defense: 10, cost: 5, special: 0, image: ""))
}
