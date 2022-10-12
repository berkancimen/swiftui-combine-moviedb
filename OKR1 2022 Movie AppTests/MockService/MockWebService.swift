//
//  MockWebService.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 26.04.2022.
//

import Foundation
import Combine

class MockWebService: NetworkService {
    
    func fetch<T: Decodable>(url: EndPoints, page: Int?) -> AnyPublisher<T, Error> {
        switch url {
        case .genre:
            let genres = [
                Genre(name: "Action", id: 1),
                Genre(name: "Comedy", id: 1),
                Genre(name: "Science", id: 1)
            ]
            let genreResponse = GenreResponse(genres: genres) as! T
            return Just<T>(genreResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .popular, .trending, .topRated:
            return getMockMovieResponse()
        case .movieDetail(let movieId):
            if movieId == 1 {
                let movieDetailResponse = MovieDetailModel(name: "Movie1") as! T
                return Just<T>(movieDetailResponse)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Empty()
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        case .search(let searchText):
            if searchText == "Search%20Test" {
                return getMockMovieResponse()
            } else {
                return Empty()
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        default:
            return Empty()
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
   
    func fetch<T: Decodable>(url: EndPoints, page: Int? = nil) async throws -> T {
        switch url {
        case .genre:
            let genres = [
                Genre(name: "Action", id: 1),
                Genre(name: "Comedy", id: 1),
                Genre(name: "Science", id: 1)
            ]
            return (GenreResponse(genres: genres) as? T)!        
        default:
            let error = NSError(domain: "Error Test", code: 0, userInfo: [:])
            throw error
        }        
    }
    
    func getMockMovieResponse<T: Decodable>() -> AnyPublisher<T, Error> {
                
        let movies = [
            Movie(title: "Movie1", id: 1, genre_ids: [5], vote_average: 2.2, poster_path: "", release_date: "2021-12-12"),
            Movie(title: "Movie2", id: 2, genre_ids: [5,8], vote_average: 5.2 , poster_path: "", release_date: "2021-12-11"),
            Movie(title: "Movie3", id: 3, genre_ids: [12], vote_average: 5.7, poster_path: "", release_date: "2021-12-10"),
            Movie(title: "Movie4", id: 4, genre_ids: [3,8], vote_average: 7.0, poster_path: "", release_date: "2021-12-09"),
            Movie(title: "Movie5", id: 5, genre_ids: [14], vote_average: 3.0, poster_path: "", release_date: "2021-12-08"),
            Movie(title: "Movie6", id: 6, genre_ids: [12], vote_average: 11.0, poster_path: "", release_date: "2021-12-07"),
            Movie(title: "Movie7", id: 7, genre_ids: [2], vote_average: 12.0, poster_path: "", release_date: "2021-12-06"),
            Movie(title: "Movie8", id: 8, genre_ids: [14], vote_average: 5.0, poster_path: "", release_date: "2022-06-05"),
            Movie(title: "Movie9", id: 9, genre_ids: [25], vote_average: 8.0, poster_path: "", release_date: "2021-12-04")
        ]
        let movieResponse = MovieResponse(results: movies) as! T
        return Just<T>(movieResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
