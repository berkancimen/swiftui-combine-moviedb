//
//  MovieDetailViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 5.06.2022.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetailModelViewModel = MovieDetailModelViewModel.default
    
    private var service: NetworkService
    private var movieId: Int
    private var cancellable: AnyCancellable?
    
    init(service: NetworkService, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
    
    func getMovieDetail() {
        let response = service.fetch(type: MovieDetailModel.self, url:EndPoints.movieDetail(movieId), page: nil)
        cancellable = response
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.movieDetail = MovieDetailModelViewModel(movie: $0)
            })
    }
    
}
