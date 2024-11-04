//
//  GameTextTitle.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

struct GameTextTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 60))
            .bold()
            .frame(maxWidth: .infinity, maxHeight: 70)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.7))
                
            }
            .foregroundStyle(
                .white
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
    }
}

#Preview {
    GameTextTitle(text: "Your Turn")
}
