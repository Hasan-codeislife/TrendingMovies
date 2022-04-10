//
//  APIManager.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
struct MyError: Error {
    
}

protocol ApiManagerProtocol {
    func makeNetworkCall<T: Codable>(router: Routable,
                                     successHandler: @escaping (T) -> Void,
                                     errorHandler: @escaping (_ error: Error,
                                                              _ message: String?) -> Void)
}

final class ApiManager: ApiManagerProtocol {
    
    private var apiClient: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.apiClient = client
    }
    
    func makeNetworkCall<T: Codable>(router: Routable,
                                     successHandler: @escaping (T) -> Void,
                                     errorHandler: @escaping (_ error: Error,
                                                              _ message: String?) -> Void) {
        
        guard let url = URL(string: router.path) else { return }
        let urlRequest = URLRequest(requestURL: url,
                                    method: router.method,
                                    header: nil,
                                    body: router.params ?? nil)
        apiClient.dataTask(urlRequest) { response in
            switch response {
            case .success((let serverResponse)):
                let statusCode = serverResponse.response.statusCode
                
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(T.self, from: serverResponse.data)
                    switch statusCode {
                    case 200:
                        successHandler(apiResponse)
                    default:
                        errorHandler(MyError(), String())
                    }
                } catch let error {
                    // MARK: JSON Parsing Error
                    errorHandler(error, error.localizedDescription)
                }
            case .failure(_):
                break
            }
        }
    }
}
