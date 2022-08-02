//
//  Search.swift
//  Yummies
//
//  Created by Yavor Radulov on 2.08.22.
//

class SearchUtil {
    
    func formatSearchTerm(searchTerm: String) -> String {
        
        let stringArray = searchTerm.components(separatedBy: " ")
        
        guard stringArray.count > 1 else { return searchTerm }
        
        let formattedSearchTerm = stringArray.joined(separator: "%20")
        
        return formattedSearchTerm
    }
}
