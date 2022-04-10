//
//  TrendingMoviesViewModel.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

protocol TrendingMoviesViewModelProtocol: AnyObject {
    // MARK:- Output
    var newMoviesFetched: Reactive<Void> { get }
    var viewModel: [TrendingMoviesCellModel] { get }
    var goToDetails: Reactive<Int?> { get }
    
    // MARK:- Input
    func getTrendingMovies()
}

final class TrendingMoviesViewModel: TrendingMoviesViewModelProtocol {
    
    var newMoviesFetched: Reactive<Void> = Reactive(())
    private var moviesService: MoviesServiceProtocol?
    var goToDetails: Reactive<Int?> = Reactive(nil)
    
    // network
    private var moviesDataModel = [TrendingMovieNetworkModel]()
    
    // for view
    var viewModel = [TrendingMoviesCellModel]()
    
    init(service: MoviesServiceProtocol) {
        moviesService = service
    }
    
    func getTrendingMovies() {
        moviesService?.getTrendingMovies(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSucessResponse(response: response)
            case .failure(let error):
                // call show toast here
                print(error.localizedDescription)
            }
        })
    }
    
    private func handleSucessResponse(response: TrendingMoviesResponse) {
        moviesDataModel = response.results ?? []
        moviesDataModel.forEach { item in
            if let path = item.posterPath,
               let posterURL = moviesService?.getPosterURL(path: path),
               let model = TrendingMoviesCellModel(item: item, posterURL: posterURL, didSelect: { [weak self] in
                   self?.goToDetails.value = item.id
               }){
                viewModel.append(model)
            }
        }
        newMoviesFetched.value = ()
    }
    
}
