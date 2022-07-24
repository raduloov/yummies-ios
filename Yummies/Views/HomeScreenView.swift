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
    @StateObject var homeVM = HomeScreenViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader()
                
                ScrollView {
                    if homeVM.isRefreshing {
                        VStack {
                            LoadingIndicator(text: "Getting recipes...", size: 2)
                        }
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
                    } else {
                        VStack(alignment: .leading) {
                            ForEach(0 ..< categories.count, id: \.self) { index in
                                Text(categories[index].title)
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.heavy)
                                    .padding(.horizontal)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(homeVM.recipes) { recipe in
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(Color.white)
                                                .frame(width: 200, height: 150)
                                                .shadow(radius: 5, x: 0, y: 5)
                                                .padding()
                                                .overlay(
                                                    Text(recipe.recipe.label)
                                                )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
