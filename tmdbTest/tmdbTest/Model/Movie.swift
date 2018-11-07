//
//  Movie.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

struct Movie: Encodable {
    
    var identifier: Int?
    var voteAverage: Double?
    var title: String?
    var originalTitle: String?
    var popularity: Double?
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var releaseDate: Date?
    var genres: [Genre]?
    var runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case voteAverage = "vote_average"
        case title
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genres
        case runtime
    }
}

extension Movie: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try values.decodeIfPresent(Int.self, forKey: .identifier)
        
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)?.toDate()
    }
}
