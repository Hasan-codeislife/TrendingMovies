//
//  TrendingMoviesCellModel.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
import UIKit

struct TrendingMoviesCellModel {
    
    let title: String
    let releaseYear: String
    let posterURL: String
    private let didSelect: () -> Void
    
    init(title: String, releaseYear: String, posterURL: String, didSelect: @escaping () -> Void) {
        self.title = title
        self.releaseYear = releaseYear
        self.posterURL = posterURL
        self.didSelect = didSelect
    }
    
    init?(item: TrendingMovieNetworkModel, posterURL: String, didSelect: @escaping () -> Void) {
        
        guard let title = item.title,
              let date = item.releaseDate,
              let releaseYear = DateConverter.getYear(dateStr: date)
        else { return nil }
        
        self.init(title: title, releaseYear: releaseYear, posterURL: posterURL, didSelect: didSelect)
    }
    
    func didTap() {
        didSelect()
    }
}
