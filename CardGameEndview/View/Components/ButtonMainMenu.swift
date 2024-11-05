//
//  ButtonMainMenu.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-03.
//

import SwiftUI

// Button component that is used when moving around in the menus.
struct ButtonMainMenu: View {
    var function: () -> Void
    var text: String
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            Text(text)
                .font(.title)
                .foregroundStyle(.thinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.3, green: 0.3, blue: 0.4))
                        .stroke(.thinMaterial, lineWidth: 4)
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 10)
        })
    }
}

#Preview {
    ButtonMainMenu(function: {
        
    }, text: "Play Button")
}
