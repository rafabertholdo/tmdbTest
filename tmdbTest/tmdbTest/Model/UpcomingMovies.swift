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
    
    func clearMovies() {
        self.movies = []
    }
    
    func isSearching() -> Bool {
        return !(searchTerm ?? "").isEmpty
    }
    
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
    
    func loadNextPage(_ completion: @escaping FetchMoviesCompletion) {
        currentPage += 1
        if isSearching() {
            searchMovie(completion)
        } else {
            fetchMovies(completion)
        }
    }
}
