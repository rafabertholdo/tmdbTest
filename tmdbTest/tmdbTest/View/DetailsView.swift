//
//  DetailsView.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsView: UIView {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /// fill Screen with movie
    ///
    /// - Parameter movie: movie object
    func fillScreen(movie: Movie) {
        loadBanner(url: movie.backdropPath)
        loadPoster(url: movie.posterPath)
        loadGenres(movie.genres, runtime: movie.runtime)
        
        if let title = movie.title {
            titleLabel.text = title
        }
        
        if let release = movie.releaseDate {
            dateLabel.text = release.toString()
        }
        
        if let description = movie.overview {
            descriptionLabel.text = description
            descriptionLabel.sizeToFit()
        }
        
        showLoading(false)
    }
    
    /// Show loading view
    ///
    /// - Parameter show: show or hide
    func showLoading(_ show: Bool) {
        if show {
            loadingView.isHidden = false
            activityIndicator.startAnimating()
        } else {
            loadingView.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func loadPoster(url: String?) {
        let placeholder = UIImage(named: "claquete")
        
        self.posterImage.image = placeholder
        self.posterImage.contentMode = .center
        
        if let url = url,
            let posterPath = URL(string: url) {
            self.posterImage?.af_setImage(withURL: posterPath, completion: { [weak self] (_) in
                guard let strongSelf = self else { return }
                strongSelf.posterImage.contentMode = .scaleAspectFill
            })
        }
    }
    
    private func loadBanner(url: String?) {
        let placeholder = UIImage(named: "claquete")
        
        self.bannerImage.image = placeholder
        self.bannerImage.contentMode = .center
        if let url = url,
            let bannerPath = URL(string: url) {
            
            self.bannerImage?.af_setImage(withURL: bannerPath, completion: { [weak self] (_) in
                guard let strongSelf = self else { return }
                strongSelf.bannerImage.contentMode = .scaleAspectFill
            })
        }
    }
    
    private func loadGenres(_ genres: [Genre]?, runtime: Int?) {
        var genresString = ""
        var runtimeString = ""
        
        if let genres = genres {
            genresString = genres.compactMap({ (gnr) -> String? in
                gnr.name
            }).joined(separator: ", ")
        }
        
        if let runtime = runtime {
            runtimeString = String(describing: runtime)
            if runtimeString.count > 0 && genresString.count > 0 {
                runtimeString = "\(runtimeString)m | "
            } else if runtimeString.count > 0 {
                runtimeString = "\(runtimeString)m"
            }
        }
        
        self.genreLabel.text = "\(runtimeString)\(genresString)"
    }
}
