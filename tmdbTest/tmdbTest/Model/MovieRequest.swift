//
//  MovieRequest.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

struct MovieRequest: Codable {
    
    var apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}
