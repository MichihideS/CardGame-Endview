//
//  LoggedInView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct LoggedInView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: { GameView() }) {
                    Text("Play Game")
                }
            }
        }
    }
}

#Preview {
    LoggedInView()
}
