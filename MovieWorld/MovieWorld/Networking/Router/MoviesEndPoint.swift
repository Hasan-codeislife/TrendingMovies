//
//  LaunchesEndPoint.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

enum MoviesEndPoint: Routable {
    
    private var apiKey: String {
        return NetworkConstants.apiKey
    }
    
    case getTrendingMovies
    case getMovieDetails(id: Int)
    case getImageURL(path: String)
    
    var path: String {
        switch self {
        case .getTrendingMovies:
            return baseURLString + "/discover/movie?api_key=\(apiKey)"
        case .getMovieDetails(let id):
            return baseURLString + "/movie/\(id)?api_key=\(apiKey)"
        case .getImageURL(let path):
            return "https://image.tmdb.org/t/p/w500\(path)"
        }
    }
    
    var params: APIParams? {
        return nil
    }
    
    var method: APIMehtod {
        switch self {
        case .getTrendingMovies:
            return .get
        case .getMovieDetails:
            return .get
        case .getImageURL:
            return .get
        }
    }
}
