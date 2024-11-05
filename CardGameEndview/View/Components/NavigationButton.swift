//
//  NavigationButton.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

// Navigation link component to navigate within a navigation stack.
struct NavigationButton <Destination: View>: View {
    var destination: Destination
    var text: String
    
    var body: some View {
        NavigationLink(destination: { destination }) {
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
        }
    }
}

#Preview {
    NavigationButton(destination: GameView(), text: "Navigate")
}
