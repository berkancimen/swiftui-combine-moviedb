//
//  NetworkMovieService.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import Foundation
import Combine

typealias MovieCompletion = (_ result: Result<[MovieViewModel], Error>) -> Void

protocol MovieServicesProtocol {
    
    func getMovies(cancallebles: inout Set<AnyCancellable>,endPoint: EndPoints, page: Int?, completion: @escaping MovieCompletion)
}

class MovieServices {
    
    var service: NetworkService
    
    required init(service: NetworkService) {
        self.service = service
    }
}

// MARK: - MovieServicesProtocol-
extension MovieServices: MovieServicesProtocol {
    
    func getMovies(cancallebles: inout Set<AnyCancellable>, endPoint: EndPoints, page: Int?, completion: @escaping MovieCompletion) {
        let response = service.fetch(type: MovieResponse.self, url: endPoint, page: page)
        response
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: {
                completion(.success(($0.results.map(MovieViewModel.init))))
            }).store(in: &cancallebles)
    }
}
