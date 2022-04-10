//
//  MovieDetailsResponse.swift
//  MovieWorld
//
//  Created by Hassan Personal on 10.04.22.
//

import Foundation

struct MovieDetailsNetworkResponse: Codable {
    var id: Int?
    var title: String?
    var posterPath: String?
    var releaseDate: String?
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
            releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            overview = try values.decodeIfPresent(String.self, forKey: .overview)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
