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
            let response: GenreResponse = try await service.fetch(urlString: EndPoints.genre.url())
            let items = response.genres
            self.genres = items.map(GenresViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func getPopularMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(urlString: EndPoints.popular.url())
            let items = response.results
            self.popularMovies = items.map(MovieViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func getTrendingMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(urlString: EndPoints.trending.url())
            let items = response.results
            self.trengingMovies = items.map(MovieViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func getTopRatedMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(urlString: EndPoints.topRated.url())
            let items = response.results
            self.topRatedMovies = items.map(MovieViewModel.init)
        } catch {
            print(error)
        }
    }
    
}
