//
//  LoggedInView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

// View for where you land when you log in.
struct LoggedInView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                VStack {
                    if let currentName = db.currentPlayerData?.name {
                        MainTextTitle(text: "Welcome: \(currentName)")
                    }
                    
                    NavigationButton(destination: GameView(), text: "Play Game")
                    
                    NavigationButton(destination: HighscoreView(), text: "Highscore")
                    
                    ButtonMainMenu(function: {
                        db.signOut()
                    }, text: "Sign Out")
                }
            }
        }
    }
}

#Preview {
    LoggedInView().environmentObject(DbConnection())
}
