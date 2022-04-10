//
//  UIImageView.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String, placeholder: UIImage) {
        self.kf.indicatorType = .none
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: nil, progressBlock: nil) {
            _ in
        }
    }
}
