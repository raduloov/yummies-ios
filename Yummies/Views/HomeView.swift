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
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("bgGradient1"), Color("bgGradient2")], startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader()
                
                ScrollView {
                    if homeVM.recipes.count != categories.count {
                        VStack {
                            LoadingIndicator(text: "Getting recipes...", size: 2)
                        }
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
                    
                    } else {
                        VStack(alignment: .leading) {
                            ForEach(0 ..< categories.count, id: \.self) { index in
                                
                                Group {
                                    Text(categories[index].title)
                                        .font(.system(.title, design: .rounded))
                                        .fontWeight(.heavy)
                                        .padding(.horizontal)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(alignment: .top) {
                                            ForEach(homeVM.recipes[index]) { recipe in
                                                MealCard(
                                                    uri: recipe.recipe.uri,
                                                    imageUrl: recipe.recipe.image,
                                                    label: recipe.recipe.label,
                                                    nutrients: recipe.recipe.totalNutrients
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
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
        .task {
            if homeVM.recipes.count < categories.count {
                await homeVM.populateCategories()
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
