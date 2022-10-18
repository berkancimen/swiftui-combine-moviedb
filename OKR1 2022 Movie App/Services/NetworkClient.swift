//
//  NetworkClient.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 18.10.2022.
//

import Foundation
import Combine

typealias GenreCompletion = (_ result: Result<[GenresViewModel], Error>) -> Void
typealias MovieCompletion = (_ result: Result<[MovieViewModel], Error>) -> Void

protocol HomeNetworkClient: AnyObject {
    
    func getGenres(cancallebles: inout Set<AnyCancellable>, completion: @escaping GenreCompletion)
    func getMovies(cancallebles: inout Set<AnyCancellable>,endPoint: EndPoints, page: Int?, completion: @escaping MovieCompletion)
}


// MARK: - HomeNetworkClient -
class NetworkClient: HomeNetworkClient {
   
    private var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func getGenres(cancallebles: inout Set<AnyCancellable>, completion: @escaping GenreCompletion) {
        let response: AnyPublisher<GenreResponse, Error> = service.fetch(url: EndPoints.genre, page: nil)
        response
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: {
                completion(.success(($0.genres.map(GenresViewModel.init))))
            }).store(in: &cancallebles)
    }
    
    func getMovies(cancallebles: inout Set<AnyCancellable>, endPoint: EndPoints, page: Int?, completion: @escaping MovieCompletion) {
        let response: AnyPublisher<MovieResponse, Error> = service.fetch(url: endPoint, page: page)
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


extension NetworkClient {
    
}
