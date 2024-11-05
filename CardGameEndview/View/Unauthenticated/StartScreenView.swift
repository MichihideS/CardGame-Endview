//
//  StartScreenView.swift
//  CardGameEndview
//
//  Created by Michihide Sugito on 2024-11-05.
//

import SwiftUI
import AVFoundation

struct StartScreenView: View {
    @EnvironmentObject var db: DbConnection
    @State private var isAnimating = false
    @State private var introText = false
    @State private var isKeyPressed = false
    
    var body: some View {
        if !isKeyPressed {
            ZStack {
                VStack {
                    Image("game_bg")
                        .opacity(isAnimating ? 1 : 0)
                        .animation(
                            isAnimating ?
                                .easeIn(duration: 5) :
                                    .default,
                            value: isAnimating
                        )
                }
                
                VStack {
                    Image("logo_tower")
                        .resizable()
                        .renderingMode(.template)
                        .opacity(isAnimating ? 0.2 : 0.6)
                        .padding(100)
                        .foregroundStyle(isAnimating ? .white : .black)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            isAnimating ?
                                .easeInOut(duration: 5) :
                                    .default,
                            value: isAnimating
                        )
                }
                
                VStack {
                    Text("EndView")
                        .bold()
                        .font(.system(size: 72))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.thinMaterial)
                                .stroke(.thinMaterial, lineWidth: 5)
                                .opacity(isAnimating ? 0.5 : 0)
                                .animation(
                                    isAnimating ?
                                        .easeInOut(duration: 1.2)
                                        .repeatForever(autoreverses: true) :
                                            .default,
                                    value: isAnimating
                                )
                            
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .animation(
                            isAnimating ?
                                .easeIn(duration: 5) :
                                    .default,
                            value: isAnimating
                        )
                    
                    
                    Text("Best card game you can find")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.thinMaterial)
                                .stroke(.thinMaterial, lineWidth: 5)
                                .opacity(isAnimating ? 0.5 : 0)
                                .animation(
                                    isAnimating ?
                                        .easeInOut(duration: 1.2)
                                        .repeatForever(autoreverses: true) :
                                            .default,
                                    value: isAnimating
                                )
                            
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .animation(
                            isAnimating ?
                                .easeIn(duration: 5) :
                                    .default,
                            value: isAnimating
                        )
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 150)
                
                Text((introText ? "Press anywhere to continue" : ""))
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.thinMaterial)
                    .opacity(isAnimating ? 1 : 0.1)
                    .animation(
                        isAnimating ?
                            .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true) :
                                .default,
                        value: isAnimating
                    )
                
                Button(action: {
                    AudioServicesPlaySystemSound(1502)
                    isKeyPressed = true
                }, label: {
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .background(Color.clear)
                })
            }
            .onAppear {
                isAnimating = true
            }
            .task {
                try? await Task.sleep(nanoseconds: 4_000_000_000)
                self.introText.toggle()
            }
        } else {
            if db.currentPlayer != nil {
                // Logged in view
                NavigationStack {
                    LoggedInView()
                }
            } else {
                // Logged out view
                NavigationStack {
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    StartScreenView().environmentObject(DbConnection())
}
