//
//  CardGameEndviewApp.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

@main
struct CardGameEndviewApp: App {
    @StateObject var game = Game()
    var body: some Scene {
        WindowGroup {
            StartView().environmentObject(game)
        }
    }
}
