//
//  HighscoreView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

// View that shows the highscore of every player in the database and sorts it by winratio.
struct HighscoreView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var game: Game
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                ScrollView {
                    Text("Player List:")
                        .font(.title)
                    
                    // Sorts the highscore list by win% with the help of a winratio function
                    ForEach(db.players.sorted(by: { game.winRatio(wins: $0.wins, losses: $0.losses) > game.winRatio(wins: $1.wins, losses: $1.losses)})) { player in
                        PlayerCard(playerData: player)}
                }
            }
        }
    }
}

#Preview {
    HighscoreView().environmentObject(DbConnection())
}
