//
//  ButtonGame.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

// Button component that is used when you are playing the game.
struct ButtonGame: View {
    var function: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            Text(text)
                .font(.title2)
                .foregroundStyle(.thinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.3, green: 0.3, blue: 0.4))
                        .stroke(.thinMaterial, lineWidth: 4)
                }
                .padding(.horizontal, 100)
                .padding(.vertical, 5)
        })
    }
}

#Preview {
    ButtonGame(function: {
        
    }, text: "End Turn")
}
