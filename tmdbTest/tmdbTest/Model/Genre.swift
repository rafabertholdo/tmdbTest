//
//  Genre.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

struct Genre: Codable {
    
    var identifier: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
