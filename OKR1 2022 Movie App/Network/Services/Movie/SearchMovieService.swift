//
//  SearchMovieService.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 26.10.2022.
//

import Foundation
import Combine

// MARK: - Movie List Service -
typealias MovieSearchtServiceCompletion = (_ result: Result<[MovieViewModel], Error>) -> Void

protocol MovieSearchServiceProtocol: AnyObject {
    func getMovies(cancallebles: inout Set<AnyCancellable>, page: Int?, searchText: String, completion: @escaping MovieListServiceCompletion)
}

extension MovieServices: MovieSearchServiceProtocol {
    
    func getMovies(cancallebles: inout Set<AnyCancellable>,  page: Int?, searchText: String, completion: @escaping MovieListServiceCompletion) {
        let response = service.fetch(type: MovieResponse.self, url: EndPoints.search(searchText), page: page)
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
