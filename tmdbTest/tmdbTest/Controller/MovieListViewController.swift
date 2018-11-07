//
//  MovieListViewController.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, ViewCustomizable {
    typealias MainView = MovieListView

    var model = UpcomingMovies()
    var selectedMovieId: Int?
    let searchController = UISearchController(searchResultsController: nil)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white

        mainView.dataSource = self
        mainView.delegate = self
        mainView.setLoadingScreen(navigationController: navigationController)

        fetchMovies()
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 8
        let distanceBetweenCells: CGFloat = 8
        let cellsByRow: CGFloat = UIDevice.current.orientation.isLandscape ? 5 : 3
        let width = (UIScreen.main.bounds.width - CGFloat(2 * margin) - CGFloat(distanceBetweenCells * (cellsByRow - 1))) / cellsByRow
        let size = CGSize(width: width,
                          height: 206) 
        return size
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let movie = model.movies[indexPath.row]
        cell.setViewModel(movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell else { return }
        movieCell.cover.af_cancelImageRequest()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == model.movies.count - 1 {
            model.loadNextPage { [weak self] (completion) in
                do {
                    try completion()
                    self?.mainView.reloadData()
                } catch {
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let movie = model.movies[indexPath.row]
        selectedMovieId = movie.identifier
        performSegue(withIdentifier: DetailsViewController.segueIdentifier,
                     sender: self)
    }
}

extension MovieListViewController: UISearchResultsUpdating {

    fileprivate func fetchMovies() {
        model.clearMovies()
        model.fetchMovies { [weak self] (completion) in
            defer {
                self?.mainView.removeLoadingScreen()
            }
            do {
                try completion()
                self?.mainView.reloadData()
            } catch {
                
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text,
            !searchTerm.isEmpty {
            model.searchTerm = searchController.searchBar.text
            model.searchMovie { [weak self] (completion) in
                defer {
                    self?.mainView.removeLoadingScreen()
                }
                do {
                    try completion()
                    self?.mainView.reloadData()
                } catch {
                    
                }
            }
        } else {
            if model.isSearching() {
                model.searchTerm = nil
                fetchMovies()
            }
        }
    }
}
