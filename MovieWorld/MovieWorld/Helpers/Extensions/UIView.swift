//
//  UIView.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
import UIKit

extension UIView {
    func setupSubviewForAutoLayout(_ child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
    }
}
