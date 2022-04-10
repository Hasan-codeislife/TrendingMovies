//
//  LaunchResponse.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
import UIKit

struct TrendingMoviesResponse: Codable {
    var results: [TrendingMovieNetworkModel]?
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            results = try values.decodeIfPresent([TrendingMovieNetworkModel].self, forKey: .results) ?? []
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct TrendingMovieNetworkModel: Codable {
    var id: Int?
    var title: String?
    var posterPath: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
            releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
            title = try values.decodeIfPresent(String.self, forKey: .title)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
