//
//  MovieCollectionViewCell.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    /// Updates visual components with the view model data
    ///
    /// - Parameter model: view model
    func setViewModel(_ model: Movie) {
        guard let coverUrl = model.posterPath else {
            return
        }
        releaseDate.text = model.releaseDate?.toString()
        releaseDate.textDropShadow()
        title.text = model.title
        if let url = URL(string: coverUrl) {
            cover.af_setImage(withURL: url)
        }
    }
}
