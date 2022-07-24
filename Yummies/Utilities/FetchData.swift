//
//  FetchData.swift
//  Yummies
//
//  Created by Yavor Radulov on 23.07.22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
}

class FetchData {
    func get<T: Decodable>(url: URL, parse: (Data) -> T?) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkError.badRequest
        }
        
        guard let result = parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}


