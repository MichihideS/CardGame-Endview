//
//  CardGameEndviewApp.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//
/*
 * - Problems Stuck At -
 *
 * Was really hard to break free code to MVVM standards cause the views dependant on the view model suddenly
 * didnt work which required the use of EnviormentObject
 *
 * Couldn't get my ZStack to work with scrollview for a long time until I found the overlay extension to views
 * which worked perfectly.
 */
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
