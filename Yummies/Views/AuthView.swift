//
//  SignInView.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import FirebaseService

struct AuthView: View {
    
    @EnvironmentObject private var authVM: AuthViewModel
    @State private var enteredEmail: String = ""
    @State private var enteredPassword: String = ""
    @State private var showError: Bool = false
    @State private var errorText: String = ""
    @State var showSignUpSheet: Bool = false
    
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
            
            VStack {
                Form {
                    Section(header: Text("Sign in with email").font(.system(.body, design: .rounded))) {
                        Group {
                            TextField("Email", text: $enteredEmail)
                            SecureField("Password", text: $enteredPassword)
                        }
                        .listRowBackground((Color.gray).opacity(0.15))
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                        .autocorrectionDisabled(true)
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(height: 130)
                
                HStack {
                    Button(action: {
                        guard !enteredEmail.isEmpty, !enteredPassword.isEmpty else {
                            errorText = "Please fill all the fields."
                            showError.toggle()
                            return
                        }
                        
                        authVM.signInWithEmail(email: enteredEmail, password: enteredPassword)
                    }) {
                        Text("Sign in").font(.system(.body, design: .rounded))
                            .foregroundColor(Color.black).opacity(0.6)
                    }
                    .buttonStyle(.bordered)
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        showSignUpSheet.toggle()
                    }) {
                        Text("Don't have an account?")
                    }
                    .padding(.trailing, 20)
                }
            }
            
            Text("—— Or continue with ——").font(.system(.body, design: .rounded))
                .foregroundColor(Color.black).opacity(0.6)
                .padding(.vertical, 30)
            
            HStack {
                Button(action: {
                    // Sign in with Apple
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(Color.black)
                    }
                }
                .frame(height: 50)
                .padding()
                .buttonStyle(.bordered)
                
                Button(action: {
                    authVM.signInWithGoogle()
                }) {
                    HStack {
                        Image("GoogleLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                    }
                }
                .frame(height: 50)
                .padding()
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .sheet(isPresented: $showSignUpSheet) {
            SignUpSheetView(showSignUpSheet: $showSignUpSheet)
        }
        .onChange(of: authVM.error) {error in
            errorText = error
            showError.toggle()
        }
        .alert(errorText, isPresented: $showError) {
            Button("Okay", role: .cancel) { }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
