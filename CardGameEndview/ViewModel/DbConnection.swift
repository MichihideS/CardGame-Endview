//
//  DbConnection.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// Class for the DB connection to Firebase.
class DbConnection: ObservableObject {
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    let COLLECTION_PLAYER_DATA = "player_data"
    
    @Published var players: [PlayerData] = []
    
    @Published var currentPlayer: User?
    @Published var currentPlayerData: PlayerData?
    
    var playerDataListener: ListenerRegistration?
    var playersListener: ListenerRegistration?
    
    // Function to sign out user.
    func signOut() {
        do {
            try auth.signOut()
            currentPlayer = nil
            currentPlayerData = nil
        } catch _ {
            
        }
    }
    
    // Function to register a user to the DB with a Email, Password and a Username.
    func registerPlayer(email: String, username: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let authResult = authResult else { return }
            
            // Create a new Player in our player collection where we name the document the same as the new users id
            
            let newPlayer = PlayerData(name: username)
            
            do {
                try self.db.collection(self.COLLECTION_PLAYER_DATA).document(authResult.user.uid).setData(from: newPlayer)
            } catch _ {
                print("Failed to create a new player")
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password)
    }
    
    init() {
        let _ = auth.addStateDidChangeListener { auth, player in
            // This function will run every time the state of authentication in our app changes.
            if let player = player {
                // User logged in.
                self.currentPlayer = player
                self.startPlayerListener()
                self.startPlayerDataListener()
                
            } else {
                // User logged out.
                self.currentPlayer = nil
                self.playersListener?.remove()
                self.playersListener = nil
                
                self.playerDataListener?.remove()
                self.playerDataListener = nil
                self.currentPlayerData = nil
            }
        }
    }
    
    /*
     * Listen to Firebase for changes and do the same changes in our app.
     * If someone adds a new player in firebase it should automatically be added to our app aswell.
     */
    
    func startPlayerListener() {
        playersListener = db.collection(COLLECTION_PLAYER_DATA).addSnapshotListener { snapshot, error in
            if let error = error {
                // Error detected.
                print("Error on snapshot: \(error.localizedDescription)")
                return
            }
            
            // If no error is found we should get a valid snapshot here.
            guard let snapshot = snapshot else { return }
            
            // At the slightest change in our collection a new copy will be made at the exact moment change was made.
            self.players = []
            
            for document in snapshot.documents {
                // The data comes in a dictionairy form and we want to convert it to a Player struct.
                do {
                    // This will fail if the data in the document doesn't match the datatype of Player struct.
                    let player = try document.data(as: PlayerData.self)
                    
                    self.players.append(player)
                } catch let error {
                    print("Conversionerror: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func startPlayerDataListener() {
        guard let currentPlayer = currentPlayer else { return }
        
        playerDataListener = db.collection(COLLECTION_PLAYER_DATA).document(currentPlayer.uid).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error listening to user data! \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            do {
                self.currentPlayerData = try snapshot.data(as: PlayerData.self)
            } catch _ {
                
            }
        }
    }
    
    // Adds one win to the user that is currently logged in
    func plusOne() {
        guard let currentPlayer = currentPlayer else { return }
        guard let currentPlayerData = currentPlayerData else { return }
        
        db.collection(COLLECTION_PLAYER_DATA)
            .document(currentPlayer.uid)
            .updateData(["wins" : currentPlayerData.wins + 1])
    }
    
    // Adds one loss to the user that is currently logged in
    func minusOne() {
        guard let currentPlayer = currentPlayer else { return }
        guard let currentPlayerData = currentPlayerData else { return }
        
        db.collection(COLLECTION_PLAYER_DATA)
            .document(currentPlayer.uid)
            .updateData(["losses" : currentPlayerData.losses + 1])
    }
}
