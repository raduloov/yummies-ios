//
//  HomeScreenView.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader()
                
                Spacer()
                
                Button(action: {
                    authVM.singOut()
                }) {
                    Text("Sign out")
                }
            }
            
        }
        

    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
