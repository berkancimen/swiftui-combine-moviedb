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
    
    private var service: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: NetworkService) {
        self.service = service
    }
   
    func getGenres() {
        let response: AnyPublisher<GenreResponse, Error> = service.fetch(url: EndPoints.genre, page: nil)
        response
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.genres = $0.genres.map(GenresViewModel.init)
            }).store(in: &cancellables)
    }
    
    func getPopularMovies() {
        let response: AnyPublisher<MovieResponse, Error> = service.fetch(url: EndPoints.popular, page: nil)
        response
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.popularMovies = $0.results.map(MovieViewModel.init)
            }).store(in: &cancellables)
    }
    
    func getTrendingMovies() {
        let response: AnyPublisher<MovieResponse, Error> = service.fetch(url: EndPoints.trending, page: nil)
        response
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.trengingMovies = $0.results.map(MovieViewModel.init)
            }).store(in: &cancellables)
    }
    
    func getTopRatedMovies() {
        let response: AnyPublisher<MovieResponse, Error> = service.fetch(url: EndPoints.topRated, page: nil)
        response
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.topRatedMovies = $0.results.map(MovieViewModel.init)
            }).store(in: &cancellables)
    }
}
