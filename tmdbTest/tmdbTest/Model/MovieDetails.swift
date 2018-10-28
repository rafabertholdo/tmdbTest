//
//  MovieDetails.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

typealias FetchMovieDetailsCompletion = (@escaping () throws -> Void) -> Void

class MovieDetails: NSObject {
    
    var movie: Movie?
    private var identifier: Int
    private var movieFetcher: MovieFetcher
    
    init(identifier: Int,
         movieFetcher: MovieFetcher = TMDBMovieFetcher()) {
        self.identifier = identifier
        self.movieFetcher = movieFetcher
    }
    
    /// Issues a request to the backend to get the movie details
    ///
    /// - Parameter completion: UI completion
    func fetchMovieDetails(_ completion: @escaping FetchMoviesCompletion) {
        movieFetcher.movieDetails(movieIdentifier: identifier) { (movieDetailsCompletion) in
            do {
                self.movie = try movieDetailsCompletion()
                completion { }
            } catch {
                completion { throw error }
            }
        }
    }
}
