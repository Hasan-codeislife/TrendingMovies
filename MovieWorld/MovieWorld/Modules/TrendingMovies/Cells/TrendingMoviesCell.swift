//
//  TrendingMoviesCell.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
import UIKit

class TrendingMoviesCell: UITableViewCell {

    static let cellID = "TrendingMoviesCell"
    
    lazy var imageViewIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewIcon.image = nil
        titleLabel.text = nil
        yearLabel.text = nil
    }
    
    func configure(with data: TrendingMoviesCellModel) {
        setupLayoutConstraints()
        setupUI(data)
    }
        
    private func setupLayoutConstraints() {
        
        let stackViewTitle = UIStackView(frame: .zero)
        setupSubviewForAutoLayout(stackViewTitle)
        stackViewTitle.set(alignment: .fill, distribution: .fill, axis: .vertical, spacing: 6)
        stackViewTitle.addArrangedSubview(titleLabel)
        stackViewTitle.addArrangedSubview(yearLabel)
        
        let stackViewMain = UIStackView(frame: .zero)
        setupSubviewForAutoLayout(stackViewMain)
        stackViewMain.set(alignment: .center, distribution: .fill, axis: .horizontal, spacing: 12)
        stackViewMain.addArrangedSubview(imageViewIcon)
        stackViewMain.addArrangedSubview(stackViewTitle)

        let constraints = [
            stackViewMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            stackViewMain.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            stackViewMain.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6),
            stackViewMain.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            imageViewIcon.heightAnchor.constraint(equalToConstant: 100),
            imageViewIcon.widthAnchor.constraint(equalToConstant: 70),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupUI(_ data: TrendingMoviesCellModel) {
        let placeholder = UIImage()
        imageViewIcon.setImage(url: data.posterURL, placeholder: placeholder)
        titleLabel.text = data.title
        yearLabel.text = data.releaseYear
    }
    
}
