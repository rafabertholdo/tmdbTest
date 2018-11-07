//
//  DetailsSegue.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

class DetailsSegue: UIStoryboardSegue {
    override func perform() {
        guard let fromViewController = self.source as? MovieListViewController else {
            return
        }
        guard let toViewController = self.destination as? DetailsViewController else {
            return
        }
        guard let movieIdentifier = fromViewController.selectedMovieId else {
            return
        }
        
        toViewController.model = MovieDetails(identifier: movieIdentifier)
        fromViewController.navigationController?.pushViewController(toViewController, animated: true)
    }
}
