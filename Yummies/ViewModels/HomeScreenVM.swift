//
//  HomeScreenVM.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import SwiftUI
import Combine

class HomeScreenViewModel: ObservableObject {
    
    @Published var recipes: [Results] = []
    @Published var isRefreshing = true
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getRecipes()
    }
    
    func getRecipes() {
        guard let url = URL(string: "\(K.BASE_URL)?type=public&beta=false&q=beef&app_id=9775e9bb&app_key=\(K.API_KEY)") else { return }
        
        isRefreshing = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: Recipes.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    self.isRefreshing = false
                case .failure(let error):
                    print("Something went wrong: \(error)")
                }
            } receiveValue: { [weak self] recipes in
                self?.recipes = recipes.hits
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}



