//
//  MockWebService.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 26.04.2022.
//

import Foundation

class MockWebService: NetworkService {
    
    static func getMockMovies() -> [MovieViewModel] {
        let movies: [MovieViewModel] = [
            MovieViewModel(movie: Movie(title: "Movie1", id: 1, genre_ids: [5], vote_average: 2.2, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie2", id: 2, genre_ids: [5,8], vote_average: 5.2 , poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie3", id: 3, genre_ids: [12], vote_average: 5.7, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie4", id: 4, genre_ids: [3,8], vote_average: 7.0, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie5", id: 5, genre_ids: [14], vote_average: 3.0, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie6", id: 6, genre_ids: [12], vote_average: 11.0, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie7", id: 7, genre_ids: [2], vote_average: 12.0, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie8", id: 8, genre_ids: [14], vote_average: 5.0, poster_path: "")),
            MovieViewModel(movie: Movie(title: "Movie9", id: 9, genre_ids: [25], vote_average: 8.0, poster_path: "")),
        ]
        return movies
    }
    
    static func getMockGenres() -> [GenresViewModel] {
        let genres: [GenresViewModel] = [
            GenresViewModel(genre: Genre(name: "Action", id: 1)),
            GenresViewModel(genre: Genre(name: "Comedy", id: 1)),
            GenresViewModel(genre: Genre(name: "Science", id: 1)),
        ]
        return genres
    }
    
    func fetchGenres() async throws -> [GenresViewModel] {
        return MockWebService.getMockGenres()
    }
    
    func fetchPopular() async throws -> [MovieViewModel] {
        return MockWebService.getMockMovies()
    }
    
    func fetchTrending() async throws -> [MovieViewModel] {
        return MockWebService.getMockMovies()
    }
    
    func fetchTopRated() async throws -> [MovieViewModel] {
        return MockWebService.getMockMovies()
    }
        
    func fetch<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "No URL", code: 0, userInfo: [:])
            throw error
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
