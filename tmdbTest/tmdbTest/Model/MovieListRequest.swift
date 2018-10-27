//
//  MovieListRequest.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

struct MovieListRequest: Codable {
    
    var apiKey: String
    var page: Int
    
    init(apiKey: String, page:Int) {
        self.apiKey = apiKey
        self.page = page
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case page
    }
    
}
