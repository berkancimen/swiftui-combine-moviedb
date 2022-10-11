//
//  WebService.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation
import Combine

protocol NetworkService {
    
    func fetch<T: Decodable>(url: EndPoints, page: Int?) async throws -> T
    func combineFetch<T: Decodable>(url: EndPoints, page: Int?) -> AnyPublisher<T, Error>
}

extension NetworkService {
    
    func combineFetch<T: Decodable>(url: EndPoints, page: Int?) -> AnyPublisher<T, Error> {
        let urlString = url.url(page: page)
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "No URL", code: 0, userInfo: [:])
            fatalError(error.localizedDescription)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class Webservice: NetworkService {
    
    func combineFetch<T: Decodable>(url: EndPoints, page: Int? = nil) -> AnyPublisher<T, Error> {
        let urlString = url.url(page: page)
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "No URL", code: 0, userInfo: [:])
            fatalError(error.localizedDescription)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetch<T: Decodable>(url: EndPoints, page: Int? = nil) async throws -> T {
        
        let urlString = url.url(page: page)
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "No URL", code: 0, userInfo: [:])
            throw error
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
