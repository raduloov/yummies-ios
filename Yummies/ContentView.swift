//
//  ContentView.swift
//  Yummies
//
//  Created by Yavor Radulov on 22.07.22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    func getUser() {
        authVM.listen()
    }
    
    var body: some View {
        Group {
            if authVM.session != nil {
                HomeScreenView()
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
