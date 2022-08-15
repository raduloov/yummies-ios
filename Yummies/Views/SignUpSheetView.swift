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
    @State private var showAlert: Bool = false
    @State private var alertText: String = ""
    @Binding var showSignUpSheet: Bool
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Create a Yummies account").font(.system(.body, design: .rounded)).padding(.top, 50)) {
                        TextField("Email", text: $enteredEmail)
                        TextField("Full name", text: $enteredFullName)
                        SecureField("Password", text: $enteredPassword)
                        SecureField("Confirm Password", text: $confirmPassword)
                }
                .textInputAutocapitalization(TextInputAutocapitalization.never)
                .autocorrectionDisabled(true)
                
                Section {
                        Button(action: {
                            guard !enteredEmail.isEmpty, !enteredPassword.isEmpty, !enteredFullName.isEmpty else {
                                alertText = "Please fill all the fields."
                                showAlert.toggle()
                                return
                            }
                            
                            guard enteredPassword == confirmPassword else {
                                alertText = "Passwords don't match."
                                showAlert.toggle()
                                return
                            }
                            
                            authVM.signUpWithEmail(email: enteredEmail, password: enteredPassword, fullName: enteredFullName)
                            
                            
                            if authVM.error == "" {
                                alertText = "Account created successfully!"
                                showAlert.toggle()
                            }
                            
                            
                        }) {
                            Text("Create account").font(.system(.body, design: .rounded))
                                .foregroundColor(Color.black).opacity(0.6)
                        }
                }
            }
        }
        .onChange(of: authVM.error) { error in
            alertText = error
            showAlert.toggle()
        }
        .alert(alertText, isPresented: $showAlert) {
            Button("Okay", role: .cancel) {
                if alertText == "Account created successfully!" {
                    showSignUpSheet.toggle()
                }
            }
        }
    }
}

struct SignUpSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSheetView(showSignUpSheet: .constant(true))
    }
}
