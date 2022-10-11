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
    
    private var cancellable: AnyCancellable?
    
    init(service: NetworkService) {
        self.service = service
    }
   
    func getGenres() {
        let response: AnyPublisher<GenreResponse, Error> = service.combineFetch(url: EndPoints.genre, page: nil)
        self.cancellable = response
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.genres = $0.genres.map(GenresViewModel.init)
            })
    }
    
    func getPopularMovies() {

//        let response: AnyPublisher<MovieResponse, Error> = service.combineFetch(url: EndPoints.popular, page: nil)
//            .receive(on: DispatchQueue.main)
//            .subscribe(Subscribers.Sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        break
//                    case .failure(let error):
//                        print(error)
//                    }
//                }, receiveValue: { [weak self] in
//                    self?.popularMovies = $0.results.map(MovieViewModel.init)
//                }
//            ))
            
        
        
//        do {
//            let response: MovieResponse = try await service.fetch(url: EndPoints.popular, page: nil)
//            let items = response.results
//            DispatchQueue.main.async {
//                self.popularMovies = items.map(MovieViewModel.init)
//            }
//        } catch {
//            print(error)
//        }
    }
    
    func getTrendingMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(url: EndPoints.trending, page: nil)
            let items = response.results
            DispatchQueue.main.async {
                self.trengingMovies = items.map(MovieViewModel.init)
            }
        } catch {
            print(error)
        }
    }
    
    func getTopRatedMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(url: EndPoints.topRated, page: nil)
            let items = response.results
            DispatchQueue.main.async {
                self.topRatedMovies = items.map(MovieViewModel.init)
            }
        } catch {
            print(error)
        }
    }
    
}
