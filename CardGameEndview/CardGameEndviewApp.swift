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
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CardGameEndviewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var dbConnection = DbConnection()
    @StateObject var game = Game()
    
    var body: some Scene {
        WindowGroup {
            StartScreenView().environmentObject(dbConnection).environmentObject(game)
        }
    }
}

/*
 * We use @StateObject when we instantiate an instance which we want SwiftUI to listen to (State).
 * When we pass it around our components as a parameter, we refer it as annotation @ObservedObject.
 * For an instance to work with @StateObject the instance has to be compliant to @ObservableObject
 */
