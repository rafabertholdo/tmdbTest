//
//  tmdbTestTests.swift
//  tmdbTestTests
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import XCTest
@testable import tmdbTest

class UpcomingMoviesTests: XCTestCase {

    var model: UpcomingMovies!
    var mock: MovieFetcherMock!
    static let movie = Movie(identifier: 1,
                             voteAverage: 1,
                             title: "a",
                             originalTitle: "a",
                             popularity: nil,
                             posterPath: nil,
                             backdropPath: nil,
                             overview: nil,
                             releaseDate: nil,
                             genres: nil,
                             runtime: nil)
    static let singleMovieList =  MovieList(page: 1,
                                            totalResults: 1,
                                            totalPages: 1,
                                            results: [UpcomingMoviesTests.movie])
    override func setUp() {
        mock = MovieFetcherMock()
        model = UpcomingMovies(movieFetcher: mock)
    }

    func testInitialState() {
        XCTAssertEqual(model.currentPage, 1)
        XCTAssertFalse(model.isSearching())
    }
    
    func testIsSearching() {
        XCTAssertFalse(model.isSearching())
        model.searchTerm = "a"
        XCTAssertTrue(model.isSearching())
    }
    
    func testFetchMovies() {
        let expectation = XCTestExpectation(description: "provider call")
        mock.movieList = UpcomingMoviesTests.singleMovieList
        model.fetchMovies { (completion) in
            expectation.fulfill()
            do {
                try completion()
                XCTAssertEqual(self.model.movies.count, 1)
                XCTAssertEqual(self.mock.upcomingMoviesCallCount, 1)
                XCTAssertEqual(self.model.movies[0].identifier, UpcomingMoviesTests.movie.identifier)
                XCTAssertTrue(self.model === self.mock.model)
            } catch {
                XCTFail("load next page should not raise errors")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchMovie() {
        let expectation = XCTestExpectation(description: "provider call")
        mock.movieList = UpcomingMoviesTests.singleMovieList
        model.searchMovie { (completion) in
            expectation.fulfill()
            do {
                try completion()
                XCTAssertEqual(self.model.movies.count, 1)
                XCTAssertEqual(self.mock.searchMovieCallCount, 1)
                XCTAssertEqual(self.model.movies[0].identifier, UpcomingMoviesTests.movie.identifier)
                XCTAssertTrue(self.model === self.mock.model)
            } catch {
                XCTFail("load next page should not raise errors")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadNextPageWithoutSearch() {
        let expectation = XCTestExpectation(description: "provider call")
        mock.movieList = UpcomingMoviesTests.singleMovieList
        model.loadNextPage { (completion) in
            expectation.fulfill()
            do {
                try completion()
                XCTAssertEqual(self.model.movies.count, 1)
                XCTAssertEqual(self.mock.upcomingMoviesCallCount, 1)
                XCTAssertEqual(self.model.movies[0].identifier, UpcomingMoviesTests.movie.identifier)
                XCTAssertTrue(self.model === self.mock.model)
            } catch {
                XCTFail("load next page should not raise errors")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadNextPageWithSearch() {
        let expectation = XCTestExpectation(description: "provider call")
        mock.movieList = UpcomingMoviesTests.singleMovieList
        model.searchTerm = "a"
        model.loadNextPage { (completion) in
            expectation.fulfill()
            do {
                try completion()
                XCTAssertEqual(self.model.movies.count, 1)
                XCTAssertEqual(self.mock.searchMovieCallCount, 1)
                XCTAssertEqual(self.model.movies[0].identifier, UpcomingMoviesTests.movie.identifier)
                XCTAssertTrue(self.model === self.mock.model)
            } catch {
                XCTFail("load next page should not raise errors")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchShouldResetDataAndPageNumber() {
        let expectation = XCTestExpectation(description: "provider call")
        mock.movieList = UpcomingMoviesTests.singleMovieList
        model.loadNextPage { (completion) in
            expectation.fulfill()
            do {
                try completion()
                self.model.searchTerm = "a"
                XCTAssertEqual(self.model.currentPage, 1)
                XCTAssertEqual(self.model.movies.count, 0)
            } catch {
                XCTFail("load next page should not raise errors")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
