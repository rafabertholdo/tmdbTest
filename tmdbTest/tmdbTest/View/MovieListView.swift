//
//  MovieListView.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

class MovieListView: UIView, ViewLoadable {
    var loadingView = UIView()
    var spinner = UIActivityIndicatorView()
    var loadingLabel = UILabel()
    weak var dataSource: UICollectionViewDataSource? {
        didSet {
            if let dataSource = dataSource {
                collectionView.dataSource = dataSource
            }
        }
    }
    
    weak var delegate: UICollectionViewDelegate? {
        didSet {
            if let delegate = delegate {
                collectionView.delegate = delegate
            }
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    func reloadData() {
        collectionView.reloadData()
    }
}
