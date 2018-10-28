//
//  SearchMovieRequest.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 28/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

struct SearchMovieRequest: Codable {
    var apiKey: String
    var searchTerm: String
    var page: Int
    
    init(apiKey: String, searchTerm: String, page: Int) {
        self.apiKey = apiKey
        self.searchTerm = searchTerm
        self.page = page
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case searchTerm = "query"
        case page
    }
}
