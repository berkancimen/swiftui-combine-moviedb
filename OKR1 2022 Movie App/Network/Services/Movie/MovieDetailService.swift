//
//  MovieDetailService.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 26.10.2022.
//

import Foundation
import Combine

// MARK: - Movie Detail Service -
typealias MovieDetailServiceCompletion = (_ result: Result<MovieDetailModelViewModel, Error>) -> Void

protocol MovieDetailServiceProtocol: AnyObject {
    func getMovieDetail(cancallebles: inout Set<AnyCancellable>, movieId: Int, completion: @escaping MovieDetailServiceCompletion)
}

extension MovieServices: MovieDetailServiceProtocol {
    
    func getMovieDetail(cancallebles: inout Set<AnyCancellable>, movieId: Int, completion: @escaping MovieDetailServiceCompletion) {
        let response = service.fetch(type: MovieDetailModel.self, url: EndPoints.movieDetail(movieId), page: nil)
        response
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: {
                let movieDetailViewModel = MovieDetailModelViewModel(movie: $0)
                completion(.success(movieDetailViewModel))
            }).store(in: &cancallebles)
    }
}
