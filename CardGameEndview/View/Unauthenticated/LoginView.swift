//
//  LoginView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var db: DbConnection
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Text("LOGIN")
                .bold()
                .font(.title)
        }
        
        VStack {
            TextField("Email address", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                db.loginUser(email: email, password: password)
            }, label: {
                Text("Login")
                    .bold()
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
            })
            
            NavigationLink(destination: { RegisterView()}) {
                Text("Register")
                    .bold()
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
            }
        }
    }
}

#Preview {
    LoginView()
}
