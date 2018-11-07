//
//  Date.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 27/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

extension Date {
    func toString(format: String = "MM/dd/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
