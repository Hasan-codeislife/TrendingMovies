//
//  TrendingMoviesViewController.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import UIKit

class TrendingMoviesViewController: UIViewController {
    
    var trendingMoviewsViewModel: TrendingMoviesViewModelProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindings()
        setupUI()
        trendingMoviewsViewModel?.getTrendingMovies()
    }
    
    convenience init(viewModel: TrendingMoviesViewModelProtocol) {
        self.init()
        self.trendingMoviewsViewModel = viewModel
    }
    
    private func bindings() {
        bindInput()
        bindOutput()
    }
    
    private func setupUI() {
        self.title = NSLocalizedString("TrendingMoviesVC.title", comment: "")
        setupTableView()
        setupLayoutConstraints()
    }
    
    private func bindInput() {
        
    }
    
    private func bindOutput() {
        trendingMoviewsViewModel?.newMoviesFetched.bind(listner: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        trendingMoviewsViewModel?.goToDetails.bind(listner: { [weak self] id in
            guard let id = id else { return }
            self?.goToDetails(with: id)
        })
    }
    
    private func setupTableView() {
        tableView.register(TrendingMoviesCell.self, forCellReuseIdentifier: TrendingMoviesCell.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setupLayoutConstraints() {
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func goToDetails(with id: Int) {
        let viewController = MovieDetailsViewController.create(with: id)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
}

extension TrendingMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingMoviewsViewModel?.viewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = trendingMoviewsViewModel?.viewModel[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: TrendingMoviesCell.cellID)
                as? TrendingMoviesCell
        else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
}

extension TrendingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = trendingMoviewsViewModel?.viewModel[indexPath.row] else { return }
        model.didTap()
    }
}
