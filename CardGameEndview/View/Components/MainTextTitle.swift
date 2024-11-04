//
//  MainTextTitle.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

struct MainTextTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, maxHeight: 70)
            .background {
                RoundedRectangle(cornerRadius: 0)
                    .fill(.thinMaterial)
                    .stroke(Color(UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1)), lineWidth: 5)
                
            }
            .foregroundStyle(
                Color(UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1))
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
    }
}

#Preview {
    MainTextTitle(text: "Main Menu")
}
