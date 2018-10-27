//
//  DetailsViewController.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, Identifiable, ViewCustomizable {
    typealias MainView = DetailsView

    var model: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.showLoading(true)
        model?.fetchMovieDetails({ [weak self] (movieDetailsCompletion) in
            do {
                self?.mainView.showLoading(false)
                try movieDetailsCompletion()
                if let movie = self?.model?.movie {
                    self?.mainView.fillScreen(movie: movie)
                }
            } catch {
                
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
