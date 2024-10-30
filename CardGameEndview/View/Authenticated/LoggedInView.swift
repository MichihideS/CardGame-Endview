//
//  LoggedInView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct LoggedInView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
            VStack {
                if let currentName = db.currentPlayerData?.name {
                    Text("Welcome: \(currentName)")
                        .bold()
                        .font(.title)
                }
               
                Button(action: {
                    db.minusOne()
                }, label: {
                        Text("CHeaT")
                })
                
                NavigationLink(destination: { GameView() }) {
                    Text("Play Game")
                }
                
                NavigationLink(destination: { HighscoreView()}) {
                    Text("Highscore")
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(.black)
                        .clipShape(.buttonBorder)
                }
                
                Button(action: {
                    db.signOut()
                }, label: {
                    Text("Sign Out")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.black)
                        .clipShape(.buttonBorder)
                })
            }
        
    }
}

#Preview {
    LoggedInView().environmentObject(DbConnection())
}
