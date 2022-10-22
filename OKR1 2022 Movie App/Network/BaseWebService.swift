//
//  WebService.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation
import Combine

protocol NetworkService {
    
    func fetch<T>(type: T.Type, url: EndPoints, page: Int?) -> AnyPublisher<T, Error> where T: Decodable
}

class Webservice: NetworkService {
    
    func fetch<T>(type: T.Type, url: EndPoints, page: Int?) -> AnyPublisher<T, Error> where T : Decodable {
        let urlString = url.url(page: page)
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "No URL", code: 0, userInfo: [:])
            fatalError(error.localizedDescription)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
