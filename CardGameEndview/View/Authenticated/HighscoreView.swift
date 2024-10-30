//
//  HighscoreView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

struct HighscoreView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Player List:")
                    .font(.title)
                
                ForEach(db.players) { player in
                    PlayerCard(playerData: player)}
            }
        }
    }
    
}

#Preview {
    HighscoreView().environmentObject(DbConnection())
}
