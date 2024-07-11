//
//  NetworkServiceProvider.swift
//  Animals
//
//  Created by Mohindra Bhati on 09/07/24.
//

import Foundation
import Combine


class NetworkServiceProvider {
    
    func fetch<T: Codable, R: ApiRequest>(_ req: R) -> AnyPublisher<T, Error> {
        var urlRequest = URLRequest(url: req.urlWithQueries())
        urlRequest.httpMethod = req.method
        urlRequest.allHTTPHeaderFields = req.headers
        urlRequest.httpBody = req.body

        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
