//
//  MoviesService.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

protocol MoviesServiceProtocol {
    func getTrendingMovies(completion: @escaping(Result<TrendingMoviesResponse, Error>) -> Void)
    func getMovieDetails(id: Int, completion: @escaping(Result<MovieDetailsNetworkResponse, Error>) -> Void)
    func getPosterURL(path: String) -> String
}

final class MoviesService: MoviesServiceProtocol {
    
    let apiManager: ApiManagerProtocol
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getTrendingMovies(completion: @escaping(Result<TrendingMoviesResponse, Error>) -> Void) {
        let endPoint = MoviesEndPoint.getTrendingMovies
        
        apiManager.makeNetworkCall(router: endPoint) { (serverResponse: TrendingMoviesResponse) in
            completion(.success(serverResponse))
        } errorHandler: { error, errorMessage in
            completion(.failure(error))
        }
        
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Result<MovieDetailsNetworkResponse, Error>) -> Void) {
        let endPoint = MoviesEndPoint.getMovieDetails(id: id)
        apiManager.makeNetworkCall(router: endPoint) { (serverResponse: MovieDetailsNetworkResponse) in
            completion(.success(serverResponse))
        } errorHandler: { error, errorMessage in
            completion(.failure(error))
        }
    }
    
    func getPosterURL(path: String) -> String {
        return MoviesEndPoint.getImageURL(path: path).path
    }
}

extension MoviesService {
    static func create() -> MoviesService {
        return MoviesService(apiManager: ApiManager(client: APIClientURLSession()))
    }
}
