//
//  Background.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

struct Background: View {
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("logo_tower")
            .resizable()
            .scaledToFill()
            .opacity(0.1)
            .padding(150)
        )
        
        .background(.thinMaterial)
    }
}

#Preview {
    Background()
}
