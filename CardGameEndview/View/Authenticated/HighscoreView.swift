//
//  HighscoreView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

struct HighscoreView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var game: Game
    
    var body: some View {
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

#Preview {
    HighscoreView().environmentObject(DbConnection())
}
