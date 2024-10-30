//
//  ContentView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var db: DbConnection

    var body: some View {
        if db.currentPlayer != nil {
            // Logged in view
            NavigationStack {
                LoggedInView()
            }
        } else {
            // Logged out view
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(DbConnection())
}
