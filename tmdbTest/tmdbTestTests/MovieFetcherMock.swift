//
//  MovieFetcherMock.swift
//  tmdbTestTests
//
//  Created by Rafael Guilherme Bertholdo on 28/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit
@testable import tmdbTest

class MovieFetcherMock: MovieFetcher {
    var model: UpcomingMovies?
    var movieIdentifier: Int?
    var upcomingMoviesCallCount = 0
    var movieDetailsCallCount = 0
    var searchMovieCallCount = 0
    var movieList: MovieList?
    var movie: Movie?
    
    func upcomingMovies(model: UpcomingMovies, completion: @escaping MovieListCallback) {
        upcomingMoviesCallCount += 1
        self.model = model
        completion { [weak self] in
            return self?.movieList
        }
    }
    
    func movieDetails(movieIdentifier: Int, completion: @escaping MovieDetailsCallback) {
        movieDetailsCallCount += 1
        completion { [weak self] in
            return self?.movie
        }
    }
    
    func searchMovie(model: UpcomingMovies, completion: @escaping MovieListCallback) {
        searchMovieCallCount += 1
        self.model = model
        completion { [weak self] in
            return self?.movieList
        }
    }
}
