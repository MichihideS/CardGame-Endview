//
//  PlayerCard.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

// Design for the playercard that is shown when you go into highscore.
struct PlayerCard: View {
    @EnvironmentObject var db: DbConnection
    var game = Game()
    
    var playerData: PlayerData
    
    var color: Color = Color(.white)
    
    var body: some View {
        VStack {
            HStack {
                Text(playerData.name)
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.leading, 30)
                
                Spacer()
                
                Text("Win%: \(String(game.winRatio(wins: playerData.wins, losses: playerData.losses)))%")
                    .bold()
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(.trailing, 30)
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            HStack {
                Text("Wins: \(String(playerData.wins))")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.leading, 50)
                
                Spacer()
                
                Text("Losses: \(String(playerData.losses))")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.trailing, 50)
            }
            .padding(.bottom, 10)
           
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(game.winRatioColor(wins: playerData.wins, Losses: playerData.losses))
                .stroke(.thinMaterial, lineWidth: 4)
        }
        .padding()
    }
}

#Preview {
    PlayerCard(playerData: PlayerData(name: "Hello"))
}
