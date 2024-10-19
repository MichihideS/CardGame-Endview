//
//  ContentView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: { LoginView() }) {
                    Text("Enter")
                }
                .padding()
            }
        }
    }
}

#Preview {
    StartView()
}
