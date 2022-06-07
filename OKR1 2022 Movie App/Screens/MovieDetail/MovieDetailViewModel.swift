//
//  MovieDetailViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 5.06.2022.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetailModelViewModel = MovieDetailModelViewModel.default
    
    private var service: NetworkService
    private var movieId: Int
    
    init(service: NetworkService, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
    
    func getMovieDetail() async {
        do {
            let response: MovieDetailModel = try await service.fetch(url: EndPoints.movieDetail(movieId), page: nil)
            DispatchQueue.main.async {
                self.movieDetail = MovieDetailModelViewModel(movie: response)
            }
        } catch {
            print(error)
        }
    }
    
}
