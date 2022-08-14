//
//  SignUpSheetView.swift
//  Yummies
//
//  Created by Yavor Radulov on 14.08.22.
//

import SwiftUI

struct SignUpSheetView: View {
    
    @EnvironmentObject private var authVM: AuthViewModel
    @State private var enteredEmail: String = ""
    @State private var enteredPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var enteredFullName: String = ""
    @State private var showError: Bool = false
    @State private var errorText: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Create a Yummies account").font(.system(.body, design: .rounded)).padding(.top, 50)) {
                        TextField("Email", text: $enteredEmail)
                        TextField("Full name", text: $enteredFullName)
                        SecureField("Password", text: $enteredPassword)
                        SecureField("Confirm Password", text: $confirmPassword)
                }
                
                Section {
                        Button(action: {
                            guard !enteredEmail.isEmpty, !enteredPassword.isEmpty, !enteredFullName.isEmpty else {
                                errorText = "Please fill all the fields."
                                showError.toggle()
                                return
                            }
                            
                            guard enteredPassword == confirmPassword else {
                                errorText = "Passwords don't match."
                                showError.toggle()
                                return
                            }
                            
                            authVM.signUpWithEmail(email: enteredEmail, password: enteredPassword, fullName: enteredFullName)
                        }) {
                            Text("Create account").font(.system(.body, design: .rounded))
                                .foregroundColor(Color.black).opacity(0.6)
                        }
                }
            }
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

struct SignUpSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSheetView()
    }
}
