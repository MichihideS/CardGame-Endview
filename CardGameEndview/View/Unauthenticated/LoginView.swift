//
//  LoginView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

// View where you can ethier login or register.
struct LoginView: View {
    @EnvironmentObject var db: DbConnection
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center) {
                VStack {
                    MainTextTitle(text: "Please Login")
                }
                
                VStack {
                    VStack {
                        TextFieldNormal(label: "Email address", text: $email)
                        
                        TextFieldSecure(label: "Password", text: $password)
                    }
                    .padding(.bottom)
                    
                    ButtonMainMenu(function: {
                        db.loginUser(email: email, password: password)
                    }, text: "Login")
                    
                    NavigationButton(destination: RegisterView(), text: "Register")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
