//
//  UIStackView.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
import UIKit

extension UIStackView {
    func set(alignment: Alignment, distribution: Distribution, axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0.0) {
        self.alignment = alignment
        self.distribution = distribution
        self.axis = axis
        self.spacing = spacing
    }
}
