//
//  MovieFetcher.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

typealias MovieListCallback = (@escaping () throws -> MovieList?) -> Void
typealias MovieDetailsCallback = (@escaping () throws -> Movie?) -> Void

protocol MovieFetcher {
    func upcomingMovies(model: UpcomingMovies, completion: @escaping MovieListCallback)
    func movieDetails(movieIdentifier: Int, completion: @escaping MovieDetailsCallback)
    func searchMovie(model: UpcomingMovies, completion: @escaping MovieListCallback)
}
