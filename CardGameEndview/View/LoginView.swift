//
//  LoginView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-10-19.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: { LoggedInView() }) {
                    Text("Login")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
