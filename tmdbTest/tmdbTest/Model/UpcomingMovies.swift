//
//  UpcomingMovies.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

typealias FetchMoviesCompletion = (@escaping () throws -> Void) -> Void

class UpcomingMovies {
    private(set) var movies: [Movie] = []
    var searchTerm: String? {
        didSet {
            clearMovies()
            currentPage = 1
        }
    }
    private(set) var currentPage = 1
    private var movieFetcher: MovieFetcher
    
    init(movieFetcher: MovieFetcher = TMDBMovieFetcher()) {
        self.movieFetcher = movieFetcher
    }
    
    /// Reset movie data
    func clearMovies() {
        self.movies = []
    }
    
    /// Checks if a search is being made
    ///
    /// - Returns: true if is searching
    func isSearching() -> Bool {
        return !(searchTerm ?? "").isEmpty
    }
    
    /// Fetches movies and concatenates the results with the list of current movies
    ///
    /// - Parameter completion: UI completion
    func fetchMovies(_ completion: @escaping FetchMoviesCompletion) {
        movieFetcher.upcomingMovies(model: self) { [weak self] (movieListCompletion) in
            do {
                let movieList = try movieListCompletion()
                if let movies = movieList?.results {
                    self?.movies.append(contentsOf: movies)
                }
                completion { }
            } catch {
                completion { throw error }
            }
        }
    }
    
    /// Fetches movies by search term and concatenates the results with the list of current movies
    ///
    /// - Parameter completion: UI completion
    func searchMovie(_ completion: @escaping FetchMoviesCompletion) {
        movieFetcher.searchMovie(model: self) { [weak self] (movieListCompletion) in
            do {
                let movieList = try movieListCompletion()
                if let movies = movieList?.results {
                    self?.movies.append(contentsOf: movies)
                }
                completion { }
            } catch {
                completion { throw error }
            }
        }
    }
    
    /// Increments de current page and issues a request to the appropriated function
    ///
    /// - Parameter completion: UI completion
    func loadNextPage(_ completion: @escaping FetchMoviesCompletion) {
        currentPage += 1
        if isSearching() {
            searchMovie(completion)
        } else {
            fetchMovies(completion)
        }
    }
}
