//
//  TMDBMovieFetcher.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

class TMDBMovieFetcher: MovieFetcher {
    
    private struct Constants {
        static let apiVersion = "3"
        static var baseUrl: String {
            return "https://api.themoviedb.org/" + apiVersion
        }
        static var upcomingEndpoint: String {
            return baseUrl + "/movie/upcoming"
        }
        static var movieEndpoint: String {
            return baseUrl + "/movie/"
        }
        static var searchEndpoint: String {
            return baseUrl + "/search/movie"
        }
        static let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
        static let bannerBaseUrl = "https://image.tmdb.org/t/p/original"
        static let apiSecret = "1f54bd990f1cdfb230adb312546d765d"
        static let profileBaseUrl = "https://image.tmdb.org/t/p/w185"
        static let results = "results"
    }
    
    private var backendClient: NetworkProviderProtocol
    
    public init(_ backendClient: NetworkProviderProtocol = AlamofireNetworkProvider.instance) {
        self.backendClient = backendClient
    }
    
    /// Fetch upcoming movies with pagination
    ///
    /// - Parameters:
    ///   - model: domain model
    ///   - completion: callback
    func upcomingMovies(model: UpcomingMovies, completion: @escaping MovieListCallback) {
        let request = MovieListRequest(apiKey: Constants.apiSecret, page: model.currentPage)
        backendClient.request(Constants.upcomingEndpoint, method: .get, parameters: request) { [weak self] (callback) in
            self?.moviesResponse( callback, completion: completion)
        }
    }
    
    /// Movie list response handler
    ///
    /// - Parameters:
    ///   - callback: api callback
    ///   - completion: domain callback
    private func moviesResponse(_ callback: @escaping () throws -> NetworkData?, completion: @escaping MovieListCallback) {
        do {
            guard let result = try callback() else {
                throw ApiError.emptyResponse
            }
            
            let decoder = JSONDecoder()
            var movies: MovieList = try decoder.decode(MovieList.self, from: result.data)
            let urlResolvedMovies = movies.results?.map({ (movie: Movie) -> Movie in
                var urlResolvedMovie = movie
                resolveURLs(&urlResolvedMovie)
                return urlResolvedMovie
            })
            movies.results = urlResolvedMovies
            completion { return movies }
        } catch {
            completion { throw error }
        }
    }
    
    /// Fill url data to Movies so the UI can issue requests to get posters
    ///
    /// - Parameter movie: movie
    fileprivate func resolveURLs(_ movie: inout Movie) {
        movie.posterPath = movie.posterPath != nil ? Constants.posterBaseUrl + movie.posterPath! : nil
        movie.backdropPath = movie.backdropPath != nil ? Constants.bannerBaseUrl + movie.backdropPath! : nil
    }
    
    /// Fetches movie details
    ///
    /// - Parameters:
    ///   - movieIdentifier: id
    ///   - completion: domain completion
    func movieDetails(movieIdentifier: Int, completion: @escaping MovieDetailsCallback) {
        let request = MovieRequest(apiKey: Constants.apiSecret)
        backendClient.request(Constants.movieEndpoint + String(movieIdentifier), method: .get, parameters: request) { [weak self] (callback) in
            do {
                guard let result = try callback() else {
                    throw ApiError.emptyResponse
                }
                
                let decoder = JSONDecoder()
                var movie: Movie = try decoder.decode(Movie.self, from: result.data)
                self?.resolveURLs(&movie)
                completion { return movie }
            } catch {
                completion { throw error }
            }
        }
    }
    
    /// Serches a movie by search term and current page
    ///
    /// - Parameters:
    ///   - model: domain model
    ///   - completion: domain completion
    func searchMovie(model: UpcomingMovies, completion: @escaping MovieListCallback) {
        let request = SearchMovieRequest(apiKey: Constants.apiSecret, searchTerm: model.searchTerm ?? "", page: model.currentPage)
        backendClient.request(Constants.searchEndpoint, method: .get, parameters: request) { [weak self] (callback) in
            self?.moviesResponse( callback, completion: completion)
        }
    }
    
}
