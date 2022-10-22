//
//  HomeViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation
import Combine

class ViewModelHome : ObservableObject {
    
    @Published var genres: [GenresViewModel] = []
    @Published var popularMovies: [MovieViewModel] = []
    @Published var trengingMovies: [MovieViewModel] = []
    @Published var topRatedMovies: [MovieViewModel] = []
    
    lazy private var genreService: GenreServicesProtocol = {
        let client = GenreServices(service: service)
        return client
    }()
    
    lazy private var movieService: MovieServicesProtocol = {
        let client = MovieServices(service: service)
        return client
    }()
    
    private var service: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: NetworkService) {
        self.service = service
    }
   
    func getGenres() {
        genreService.getGenres(cancallebles: &cancellables) { result in
            switch result {
            case .success((let genres)):
                self.genres = genres
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPopularMovies() {
        movieService.getMovies(cancallebles: &cancellables, endPoint: .popular, page: nil) { result in
            switch result {
            case .success((let movies)):
                self.popularMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTrendingMovies() {
        movieService.getMovies(cancallebles: &cancellables, endPoint: .trending, page: nil) { result in
            switch result {
            case .success((let movies)):
                self.trengingMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTopRatedMovies() {
        movieService.getMovies(cancallebles: &cancellables, endPoint: .topRated, page: nil) { result in
            switch result {
            case .success((let movies)):
                self.topRatedMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
