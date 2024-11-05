//
//  Background.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

// General background for all the views.
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
        .background(Color.blue.opacity(0.4))
    }
}

#Preview {
    Background()
}
