//
//  PlayerCard.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

struct PlayerCard: View {
    @EnvironmentObject var db: DbConnection
    var game = Game()
    
    var playerData: PlayerData
    
    var body: some View {
        VStack {
            Text(playerData.name)
                .bold()
                .font(.title)
                .foregroundStyle(.white)
            
            HStack {
                Text("Wins: \(String(playerData.wins))")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("Losses: \(String(playerData.losses))")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
            }
            
            Text("Win%: \(String(game.winRatio(wins: playerData.wins, losses: playerData.losses)))%")
                .bold()
                .font(.title2)
                .foregroundStyle(.white)
        }
        .frame(width: 300, height: 150)
        .background(.green)
        .clipShape(.buttonBorder)
    }
}

#Preview {
    PlayerCard(playerData: PlayerData(name: "Hello"))
}
