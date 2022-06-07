//
//  MockWebService.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 26.04.2022.
//

import Foundation

class MockWebService: NetworkService {
    
    func fetch<T: Decodable>(url: EndPoints, page: Int? = nil) async throws -> T {
        switch url {
        case .genre:
            let genres = [
                Genre(name: "Action", id: 1),
                Genre(name: "Comedy", id: 1),
                Genre(name: "Science", id: 1)
            ]
            return (GenreResponse(genres: genres) as? T)!
        case .popular, .trending, .topRated:
            let movies: [Movie] = [
                Movie(title: "Movie1", id: 1, genre_ids: [5], vote_average: 2.2, poster_path: ""),
                Movie(title: "Movie2", id: 2, genre_ids: [5,8], vote_average: 5.2 , poster_path: ""),
                Movie(title: "Movie3", id: 3, genre_ids: [12], vote_average: 5.7, poster_path: ""),
                Movie(title: "Movie4", id: 4, genre_ids: [3,8], vote_average: 7.0, poster_path: ""),
                Movie(title: "Movie5", id: 5, genre_ids: [14], vote_average: 3.0, poster_path: ""),
                Movie(title: "Movie6", id: 6, genre_ids: [12], vote_average: 11.0, poster_path: ""),
                Movie(title: "Movie7", id: 7, genre_ids: [2], vote_average: 12.0, poster_path: ""),
                Movie(title: "Movie8", id: 8, genre_ids: [14], vote_average: 5.0, poster_path: ""),
                Movie(title: "Movie9", id: 9, genre_ids: [25], vote_average: 8.0, poster_path: "")
            ]
            return (MovieResponse(results: movies) as? T)!
        default:
            fatalError()
        }
        
        
    }
}
