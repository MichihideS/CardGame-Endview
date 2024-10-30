//
//  RegisterView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-30.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var db: DbConnection
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var name = ""
    
    var body: some View {
        VStack {
            Text("Create account")
                .bold()
                .font(.title)
        }
        
        VStack {
            TextField("Email address", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            TextField("Username", text: $name)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                db.registerPlayer(email: email, username: name, password: password)
            }, label: {
                Text("Register")
                    .bold()
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.buttonBorder)
            })
        }
        
    }
}

#Preview {
    RegisterView()
}
