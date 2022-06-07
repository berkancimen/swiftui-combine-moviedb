//
//  HomeViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation

@MainActor
class ViewModelHome : ObservableObject{
    
    @Published var genres: [GenresViewModel] = []
    @Published var popularMovies: [MovieViewModel] = []
    @Published var trengingMovies: [MovieViewModel] = []
    @Published var topRatedMovies: [MovieViewModel] = []
    
    private var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
        
    func getGenres() async {
        do {
            let response: GenreResponse = try await service.fetch(url: EndPoints.genre, page: nil)
            let items = response.genres
            self.genres = items.map(GenresViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func getPopularMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(url: EndPoints.popular, page: nil)
            let items = response.results
            self.popularMovies = items.map(MovieViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func getTrendingMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(url: EndPoints.trending, page: nil)
            let items = response.results
            self.trengingMovies = items.map(MovieViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func getTopRatedMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(url: EndPoints.topRated, page: nil)
            let items = response.results
            self.topRatedMovies = items.map(MovieViewModel.init)
        } catch {
            print(error)
        }
    }
    
}
