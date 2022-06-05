//
//  Constants.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation

enum ScreenNames: String {
    
    case genres = "Genres"
    case popular = "Popular Movies"
    case trending = "Trending Movies"
    case topRated = "Top Rated Movies"
    
    func getEndPoint() -> EndPoints {
        switch self {
        case .popular:
            return EndPoints.popular
        case .trending:
            return EndPoints.trending
        case .topRated:
            return EndPoints.topRated
        case .genres:
            return EndPoints.genre
        }
    }
    
    var description: String {
        return self.rawValue
    }
    
}

enum EndPoints {
    
    case genre
    case popular
    case trending
    case topRated
    case movieDetail(Int)
    
    func url(page: Int? = nil) -> String {
        
        var baseUrl: String { return "https://api.themoviedb.org/3"}
        var apiToken: String {return "?api_key=f74b7953c0527670d96035f6abfaca67"}
        var paging: String {return page == nil ? "" : "&page=\(page ?? 1)"}
        
        switch self {
        case .genre:
            return "\(baseUrl)/genre/movie/list" + apiToken
        case .popular:
            return "\(baseUrl)/movie/popular" + apiToken + paging
        case .trending:
            return "\(baseUrl)/trending/movie/week" + apiToken
        case .topRated:
            return "\(baseUrl)/movie/top_rated" + apiToken + paging
        case .movieDetail(let movieId):
            return "\(baseUrl)/movie/\(movieId)" + apiToken
        }
    }
}
