//
//  RegisterView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

// View where you can register an account that gets added to FireBase DB.
struct RegisterView: View {
    @EnvironmentObject var db: DbConnection
    @State var email = ""
    @State var password = ""
    @State var name = ""
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                VStack {
                    MainTextTitle(text: "Create Account")
                }
                
                VStack {
                    TextFieldNormal(label: "Email address", text: $email)
                    
                    TextFieldNormal(label: "Username", text: $name)
                    
                    TextFieldSecure(label: "Password", text: $password)
                        .padding(.bottom)
                    
                    ButtonMainMenu(function: {
                        db.registerPlayer(email: email, username: name, password: password)
                    }, text: "Register")
                    
                    NavigationButton(destination: LoginView(), text: "Cancel")
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
