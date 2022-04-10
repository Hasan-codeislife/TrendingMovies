//
//  MovieDetailsViewModel.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    // MARK:- Output
    var movieDetailsFetched: Reactive<Void> { get }
    var trendingMovieID: Int { get }
    var viewModel: MovieDetailsViewController.Model? { get }
   
    // MARK:- Input
    func getMovieDetails()
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var trendingMovieID: Int
    var movieDetailsFetched: Reactive<Void> = Reactive(())
    private var moviesService: MoviesServiceProtocol?
    
    // network
    private var movieDetailsDataModel: MovieDetailsNetworkResponse?
    
    // for view
    var viewModel: MovieDetailsViewController.Model?
   
    init(trendingMovieID: Int, service: MoviesServiceProtocol) {
        self.trendingMovieID = trendingMovieID
        moviesService = service
    }
    
    func getMovieDetails() {
        moviesService?.getMovieDetails(id: trendingMovieID, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSucessResponse(response: response)
            case .failure(let error):
                // call show toast here
                print(error.localizedDescription)
            }
        })
    }
    
    private func handleSucessResponse(response: MovieDetailsNetworkResponse) {
        movieDetailsDataModel = response
        guard let title = response.title,
              let date = response.releaseDate,
              let releaseYear = DateConverter.getYear(dateStr: date),
              let path = response.posterPath,
              let posterURL = moviesService?.getPosterURL(path: path),
              let overview = response.overview
        else { return }
        let viewModel = MovieDetailsViewController.Model(title: title, releaseYear: releaseYear, posterURL: posterURL, overview: overview)
        self.viewModel = viewModel
        movieDetailsFetched.value = ()
    }
}
