//
//  RulesView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-05.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                MainTextTitle(text: "Rules")
                VStack {
                    Text("To win the game you have to reduce your opponents HP to 0.")
                        .padding()
                    Text("The Damage you do is based on the attack of a card, defense of the enemy and the special attribute of a card.")
                        .padding()
                    Text("Every turn start you will draw a card and every time you end turn you will draw a card.")
                        .padding()
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .center)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.thinMaterial)
                        .stroke(.black, lineWidth: 3)
                        .opacity(0.8)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    RulesView()
}
