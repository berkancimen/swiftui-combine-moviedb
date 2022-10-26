//
//  GenreServices.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import Foundation
import Combine

typealias GenreCompletion = (_ result: Result<[GenresViewModel], Error>) -> Void

protocol GenreServicesProtocol: AnyObject {
    
    func getGenres(cancallebles: inout Set<AnyCancellable>, completion: @escaping GenreCompletion)
}

class GenreServices {
    
    var service: NetworkServiceProtocol
    
    required init(service: NetworkServiceProtocol) {
        self.service = service
    }
}

// MARK: - GenreServicesProtocol-
extension GenreServices: GenreServicesProtocol {
    
    func getGenres(cancallebles: inout Set<AnyCancellable>, completion: @escaping GenreCompletion) {
        let response = service.fetch(type: GenreResponse.self, url: EndPoints.genre, page: nil)
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
}
