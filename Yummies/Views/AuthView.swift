//
//  SignInView.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import FirebaseService

struct AuthView: View {
    
    @EnvironmentObject var signInVM: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(LinearGradient(colors: [Color.pink, Color.purple], startPoint: .top, endPoint: .bottom))
                    .shadow(color: Color.gray, radius: 3, x: 0, y: 4)
                
                Text("Yummies")
                    .font(.system(size: 60, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundStyle(LinearGradient(colors: [Color.pink, Color.purple], startPoint: .top, endPoint: .bottom))
                    .shadow(color: Color.gray, radius: 3, x: 0, y: 4)
            }
            .frame(height: 50)
            
            Text("Eat Right")
                .font(.system(.title, design: .rounded))
                .foregroundColor(Color.gray)
            
            Spacer()

            Button(action: {
                signInVM.signUpWithGoogle()
            }) {
                HStack {
                    Image("GoogleLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)

                    Text("Sign in with Google")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.medium)
                        .kerning(1.2)
                }
            }
            .frame(height: 50)
            .padding()
            .foregroundColor(Color.black)
            .background(
                Capsule().strokeBorder(Color.black)
            )
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
