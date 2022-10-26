//
//  MovieListService.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 26.10.2022.
//

import Foundation
import Combine

// MARK: - Movie List Service -
typealias MovieListServiceCompletion = (_ result: Result<[MovieViewModel], Error>) -> Void

protocol MovieListServiceProtocol: AnyObject {
    func getMovies(cancallebles: inout Set<AnyCancellable>,endPoint: EndPoints, page: Int?, completion: @escaping MovieListServiceCompletion)
}

extension MovieServices: MovieListServiceProtocol {
    
    func getMovies(cancallebles: inout Set<AnyCancellable>, endPoint: EndPoints, page: Int?, completion: @escaping MovieListServiceCompletion) {
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
