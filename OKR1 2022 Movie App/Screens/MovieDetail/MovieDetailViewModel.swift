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
    
    private var service: NetworkServiceProtocol
    private var movieId: Int
    private var cancellables = Set<AnyCancellable>()
    lazy private var movieDetailService: MovieDetailServiceProtocol = {
        let client = MovieServices(service: service)
        return client
    }()
    
    init(service: NetworkServiceProtocol, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
    
    func getMovieDetail() {
        movieDetailService.getMovieDetail(cancallebles: &cancellables, movieId: movieId) { result in
            switch result {
            case .success((let movieDetail)):
                self.movieDetail = movieDetail
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
