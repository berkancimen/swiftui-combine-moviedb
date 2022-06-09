//
//  Constants.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation

enum ScreenNames {
    
    case popular
    case trending
    case topRated
    case genre(String, Int)
    
    func getScreenName() -> String {
        switch self {
        case .popular:
            return "Popular Movies"
        case .trending:
            return "Trending Movies"
        case .topRated:
            return "Top Rated Movies"
        case .genre(let name, _):
            return "\(name) Movies"
        }
    }
    
    func getEndPoint() -> EndPoints {
        switch self {
        case .popular:
            return EndPoints.popular
        case .trending:
            return EndPoints.trending
        case .topRated:
            return EndPoints.topRated
        case .genre(_, let genreId):
            return EndPoints.discoverGenre("\(genreId)")
        }
    }
    
}

enum EndPoints {
    
    case genre
    case popular
    case trending
    case topRated
    case movieDetail(Int)
    case discoverGenre(String)
    case search(String)
    
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
        case .discoverGenre(let genre):
            return "\(baseUrl)/discover/movie" + apiToken + paging + "&with_genres=\(genre)"
        case .search(let searchText):
            return "\(baseUrl)/search/movie" + apiToken + paging + "&query=\(searchText)"
        }
    }
}


extension Thread {
    var isRunningXCTest: Bool {
      threadDictionary.allKeys
        .contains {
          ($0 as? String)?
            .range(of: "XCTest", options: .caseInsensitive) != nil
        }
      }
  }
