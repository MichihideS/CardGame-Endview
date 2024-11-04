//
//  TextField.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-04.
//

import SwiftUI

struct TextFieldNormal: View {
    @State var label: String
    @State var text: Binding<String>
    
    var body: some View {
        TextField(label, text: text)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 60)
    }
}


