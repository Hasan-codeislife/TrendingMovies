//
//  APIClient.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

typealias URLResponse = Result<(data: Data, response: HTTPURLResponse), Error>

protocol APIClientProtocol {
    func dataTask(_ request: URLRequest,
                  completionHandler: @escaping (URLResponse) -> Void)
}

final class APIClientURLSession: APIClientProtocol {
    func dataTask(_ request: URLRequest,
                  completionHandler: @escaping (URLResponse) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                completionHandler(.success((data, response)))
            } else {
                let error = error ?? NSError()
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}
