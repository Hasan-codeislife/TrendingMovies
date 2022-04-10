//
//  Routable.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias APIParams = [String: Any]?
typealias APIHeaders = [String: String]
typealias APIMehtod = APIMethod


protocol Routable {
    /// baseURL for calling any server
    var baseURLString: String { get }
    
    /// by default method is HTTPMethod.get
    var method: APIMehtod { get }
    
    /// path should be appended with baseURL
    var path: String { get }
    var params: APIParams? { get }
}

extension Routable {
    
    var baseURLString: String {
        return NetworkConstants.baseUrl
    }
}
