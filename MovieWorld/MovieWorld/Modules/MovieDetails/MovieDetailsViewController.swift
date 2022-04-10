//
//  MovieDetailsViewController.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    struct Model {
        let title: String
        let releaseYear: String
        let posterURL: String
        let overview: String
    }
    
    var movieDetailsViewModel: MovieDetailsViewModelProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overivewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindings()
        setupUI()
        movieDetailsViewModel?.getMovieDetails()
    }
    
    convenience init(viewModel: MovieDetailsViewModelProtocol) {
        self.init()
        self.movieDetailsViewModel = viewModel
    }
    
    private func bindings() {
        bindInput()
        bindOutput()
    }
    
    private func setupUI() {
        self.title = NSLocalizedString("DetailsMoviesVC.title", comment: "")
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        setupScrollView()
        let stackViewMain = UIStackView(frame: .zero)
        contentView.setupSubviewForAutoLayout(stackViewMain)
        stackViewMain.set(alignment: .center, distribution: .fill, axis: .vertical, spacing: 14)
        
        stackViewMain.addArrangedSubview(posterImageView)
        stackViewMain.addArrangedSubview(titleLabel)
        stackViewMain.addArrangedSubview(yearLabel)
        stackViewMain.addArrangedSubview(overivewLabel)
        
        let constraints = [
            stackViewMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            stackViewMain.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            stackViewMain.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 14),
            stackViewMain.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            posterImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func bindInput() {
        
    }
    
    private func bindOutput() {
        movieDetailsViewModel?.movieDetailsFetched.bind(listner: { [weak self] _ in
            DispatchQueue.main.async {
                guard let model = self?.movieDetailsViewModel?.viewModel
                else { return }
                self?.setData(with: model)
            }
        })
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setData(with model: Model) {
        titleLabel.text = model.title
        yearLabel.text = model.releaseYear
        posterImageView.setImage(url: model.posterURL, placeholder: UIImage())
        overivewLabel.text = model.overview
    }
}

extension MovieDetailsViewController {
    static func create(with id: Int) -> UIViewController {
        let viewModel = MovieDetailsViewModel(trendingMovieID: id, service: MoviesService.create())
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
